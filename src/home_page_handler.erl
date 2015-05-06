-module(home_page_handler).
-author("venkateshk@ybrantdigital.com").

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

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
	% Url_Top_News = "http://api.contentapi.ws/news?channel=health_news_online&limit=6&format=short&skip=7",
	Url_Top_News = "http://api.contentapi.ws/news?channel=fitness&limit=4&format=short&skip=10",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, Response_Top_News} = ibrowse:send_req(Url_Top_News,[],get,[],[]),
	Res_Top_News = jsx:decode(list_to_binary(Response_Top_News)),
	Params1 = proplists:get_value(<<"articles">>, Res_Top_News),

	Url_Top_News1 = "http://api.contentapi.ws/news?channel=health_news_online&limit=4&format=short&skip=7",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, Response_Top_News1} = ibrowse:send_req(Url_Top_News1,[],get,[],[]),
	Res_Top_News1 = jsx:decode(list_to_binary(Response_Top_News1)),
	Params11 = proplists:get_value(<<"articles">>, Res_Top_News1),

	% Url_Top_News_Images_Limit = "http://api.contentapi.ws/news?channel=health_news_online&limit=3&format=short&skip=0",
	Url_Top_News_Images_Limit = "http://api.contentapi.ws/news?channel=fitness&limit=3&format=short&skip=0",
	
	{ok, "200", _, Response_Top_News_Images_Limit} = ibrowse:send_req(Url_Top_News_Images_Limit,[],get,[],[]),
	Res_Top_News_Images_Limit = jsx:decode(list_to_binary(Response_Top_News_Images_Limit)),
	Params2 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit),

	% Url_Top_News_Images_Limit_Skip = "http://api.contentapi.ws/news?channel=health_news_online&limit=4&format=short&skip=3",
	Url_Top_News_Images_Limit_Skip = "http://api.contentapi.ws/news?channel=fitness&limit=2&format=short&skip=3",
	
	{ok, "200", _, Response_Top_News_Images_Limit_Skip} = ibrowse:send_req(Url_Top_News_Images_Limit_Skip,[],get,[],[]),
	Res_Top_News_Images_Limit_Skip = jsx:decode(list_to_binary(Response_Top_News_Images_Limit_Skip)),
	Params3 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit_Skip),

	
	Url_Top_News_Images_Limit_Skip1 = "http://api.contentapi.ws/news?channel=fitness&limit=8&skip=0&format=short",
	
	{ok, "200", _, Response_Top_News_Images_Limit_Skip1} = ibrowse:send_req(Url_Top_News_Images_Limit_Skip1,[],get,[],[]),
	Res_Top_News_Images_Limit_Skip1 = jsx:decode(list_to_binary(Response_Top_News_Images_Limit_Skip1)),
	Params4 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit_Skip1),

	{ok, Body} = index_dtl:render([{<<"news">>,Params1},{<<"news1">>,Params11},{<<"news_images">>,Params2},{<<"news_images_limit">>,Params3},{<<"fitness_data">>,Params4}]),
    % {ok, Body} = sidebar_dtl:render([{<<"fitness_data">>,Params4}]),
    {Body, Req, State}
.