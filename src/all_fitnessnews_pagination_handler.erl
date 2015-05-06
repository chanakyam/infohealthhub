-module(all_fitnessnews_pagination_handler).
-author("venkateshk@ybrantdigital.com").

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

-include("includes.hrl").
%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	{PageBinary, PageNumber} = cowboy_req:qs_val(<<"p">>, Req),
	PageNum = list_to_integer(binary_to_list(PageBinary)),
	SkipItems = (PageNum-1) * ?NEWS_PER_PAGE,

	Url_Top_News1 = "http://api.contentapi.ws/news?channel=health_news_online&limit=6&format=short&skip=7",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, Response_Top_News1} = ibrowse:send_req(Url_Top_News1,[],get,[],[]),
	Res_Top_News1 = jsx:decode(list_to_binary(Response_Top_News1)),
	Params11 = proplists:get_value(<<"articles">>, Res_Top_News1),
	
	Url_Top_News = string:concat("http://api.contentapi.ws/news?channel=fitness&limit=10&format=short&skip=", integer_to_list(SkipItems)),
	% Url_Top_News = string:concat("http://api.contentapi.ws/news?channel=fitness&limit=10&format=short&skip=", integer_to_list(SkipItems)),
	
	{ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_Top_News,[],get,[],[]),
	ResponseParams = jsx:decode(list_to_binary(ResponseAllNews)),
	ResAllNews = proplists:get_value(<<"articles">>, ResponseParams),

	% Url_Top_News_Images_Limit_Skip1 = "http://api.contentapi.ws/news?channel=fitness&limit=10&skip=0&format=short",
	Url_Top_News_Images_Limit_Skip1 = "http://api.contentapi.ws/news?channel=health_news_online&limit=10&skip=6&format=short",
	
	{ok, "200", _, Response_Top_News_Images_Limit_Skip1} = ibrowse:send_req(Url_Top_News_Images_Limit_Skip1,[],get,[],[]),
	Res_Top_News_Images_Limit_Skip1 = jsx:decode(list_to_binary(Response_Top_News_Images_Limit_Skip1)),
	Params4 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit_Skip1),

	{ok, Body} = all_fitnessnews_paginated_dtl:render([{<<"news">>,ResAllNews},{<<"hnews">>,Params11},{"fitness_data",Params4}]),
    {Body, Req, State}
	
.