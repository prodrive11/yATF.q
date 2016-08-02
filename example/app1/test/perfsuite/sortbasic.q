system "l ", getenv[`BUILD_DIR],"/example/src/sort.q"

.t.E ((1 1 2 3); sleepsort[1 3 2 1]);
.t.G 6000, system "t sleepsort[1 2 1]";

.t.N (`dssadf; 1 2 3);
// .t.T (`f; 1 2 3);