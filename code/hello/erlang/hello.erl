%% -*- coding: utf-8 -*-
-module(hello).
-export([main/0]).

main() -> io:fwrite(<<"こんにちは、世界！\n"/utf8>>).
