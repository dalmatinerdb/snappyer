%% Copyright 2011,  Filipe David Manana  <fdmanana@apache.org>
%% Web:  http://github.com/fdmanana/snappy-erlang-nif
%%
%% Licensed under the Apache License, Version 2.0 (the "License"); you may not
%% use this file except in compliance with the License. You may obtain a copy of
%% the License at
%%
%%  http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
%% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
%% License for the specific language governing permissions and limitations under
%% the License.

-module(snappiest).

-export([compress/1, decompress/1]).
-export([uncompressed_length/1, is_valid/1]).

-on_load(init/0).

-spec init() -> ok.
init() ->
  PrivDir =
    case code:priv_dir(snappiest) of
      {error, bad_name} ->
        {ok, Cwd} = file:get_cwd(),
        Priv = filename:join([Cwd, "..", "priv"]),
        case filelib:is_dir(Priv) of
          true  -> Priv;
          false -> filename:join(Cwd, "priv")
        end;
      Dir ->
        Dir
    end,
  SoName = filename:join([PrivDir, snappiest_nif]),
  _ = erlang:load_nif(SoName, 0),
  case erlang:system_info(otp_release) of
    "R13B03" -> true;
    _        -> ok
  end.

-spec compress(iodata()) -> {ok, binary()} | no_return().
compress(_IoList) ->
  erlang:nif_error(snappy_nif_not_loaded).

-spec decompress(iodata()) -> {ok, binary()} | no_return().
decompress(_IoList) ->
  erlang:nif_error(snappy_nif_not_loaded).

-spec uncompressed_length(iodata()) -> non_neg_integer() | no_return().
uncompressed_length(_IoList) ->
  erlang:nif_error(snappy_nif_not_loaded).

-spec is_valid(iodata()) -> boolean() | no_return().
is_valid(_IoList) ->
  erlang:nif_error(snappy_nif_not_loaded).

