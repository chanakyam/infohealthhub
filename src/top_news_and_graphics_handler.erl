-module(top_news_and_graphics_handler).
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
	% Url = "http://api.contentapi.ws/news?channel=health_news_online&limit=3&skip=0&format=short",
	Url = "http://api.contentapi.ws/news?channel=fitness&limit=10&skip=0&format=short",
	% http://contentapi.ws/news?channel=image_galleries&limit=1&skip=0&format=long&asc=true
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	Body = list_to_binary(Response_mlb),
	{Body, Req, State}.


