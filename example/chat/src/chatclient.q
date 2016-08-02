.chat.hostport:"J"$getenv[`BPORT];
.chat.h:neg @[hopen;.chat.hostport;{[e] -2 "Can't connect to chat server, e:",e; exit 1}];
.chat.sub:{[topic] .chat.h (`sub; topic)};
.chat.msg:{[topic;msg] .chat.h (`.chat.dist; topic;msg)};
.chat.mh:{[m] .chat.hist,:enlist m};
.chat.sub[`];

