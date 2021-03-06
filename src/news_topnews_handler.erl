-module(news_topnews_handler).
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
		{<<"application/json">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	{Count, _ } = cowboy_req:qs_val(<<"n">>, Req),
	{Skip, _ } = cowboy_req:qs_val(<<"s">>, Req),
	lager:info("Top 10 News items requested"),
	Url = infohealthhub_util:news_top_text_news_with_limit_and_skip(binary_to_list(Count), binary_to_list(Skip)),
	{ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	Body = list_to_binary(Res),
	{Body, Req, State}.

