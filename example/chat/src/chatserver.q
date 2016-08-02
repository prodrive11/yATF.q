//system "p ",getenv[`BPORT];
// \e 1
.dist:()!();
.users:()!();
register:{[name] if[not .z.w in key .users; .users[.z.w]:string name] };
sub:{[topic] .dist[topic],:neg .z.w };
del:{[topic] .dist[topic]:.dist[topic] except neg .z.w};
/.chat.dist:{[topic;msg] (.dist[topic] except neg .z.w)@\:({[m] -1 m}; .users[.z.w],": ",msg) };
.chat.dist:{[topic;msg] (.dist[topic] except neg .z.w)@\:(`.chat.mh; .users[.z.w],": ",msg) };

.z.pw:{[x;y] register[x]; 1b }

