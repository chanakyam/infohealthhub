-module(news_page_handler).
-author("tapanp@koderoom.com").

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
	{[{Name,Value}], Req2} = cowboy_req:bindings(Req),
	
	Url = string:concat("http://api.contentapi.ws/t?id=",binary_to_list(Value) ),
	{ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	Params = jsx:decode(list_to_binary(Res)),

	% Url_Top_News = "http://api.contentapi.ws/news?channel=health_news_online&limit=10&format=short&skip=0",
	Url_Top_News = "http://api.contentapi.ws/news?channel=fitness&limit=10&format=short&skip=0",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, Response_Top_News} = ibrowse:send_req(Url_Top_News,[],get,[],[]),
	Res_Top_News = jsx:decode(list_to_binary(Response_Top_News)),
	Params1 = proplists:get_value(<<"articles">>, Res_Top_News),

	Url_Top_News_Images_Limit_Skip1 = "http://api.contentapi.ws/news?channel=health_news_online&limit=10&skip=0&format=short",
	
	{ok, "200", _, Response_Top_News_Images_Limit_Skip1} = ibrowse:send_req(Url_Top_News_Images_Limit_Skip1,[],get,[],[]),
	Res_Top_News_Images_Limit_Skip1 = jsx:decode(list_to_binary(Response_Top_News_Images_Limit_Skip1)),
	Params4 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit_Skip1),

	{ok, Body} = news_page_dtl:render([{"newsitem",Params},{"topnews",Params1},{"fitness_data",Params4}]),
    {Body, Req2, State}.


