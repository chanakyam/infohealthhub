-module(tnc_page_handler).
-author("shree@ybrantdigital.com").

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
	Url_Top_News_Images_Limit_Skip1 = "http://api.contentapi.ws/news?channel=health_news_online&limit=10&skip=0&format=short",
	
	{ok, "200", _, Response_Top_News_Images_Limit_Skip1} = ibrowse:send_req(Url_Top_News_Images_Limit_Skip1,[],get,[],[]),
	Res_Top_News_Images_Limit_Skip1 = jsx:decode(list_to_binary(Response_Top_News_Images_Limit_Skip1)),
	Params4 = proplists:get_value(<<"articles">>, Res_Top_News_Images_Limit_Skip1),

	{ok, Body} = tnc_dtl:render([{"fitness_data",Params4}]),
    {Body, Req, State}	
.