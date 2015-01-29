#!/bin/ksh
mkdir extract_sep
cat LOG_GO_SEP | grep dl1.hits > extract_sep/dl1_hits
cat LOG_GO_SEP | grep il1.hits > extract_sep/il1_hits
cat LOG_GO_SEP | grep dl2.hits > extract_sep/dl2_hits
cat LOG_GO_SEP | grep il2.hits > extract_sep/il2_hits
cat LOG_GO_SEP | grep il1.misses > extract_sep/il1_misses
cat LOG_GO_SEP | grep dl1.misses > extract_sep/dl1_misses
cat LOG_GO_SEP | grep il2.misses > extract_sep/il2_misses
cat LOG_GO_SEP | grep dl2.misses > extract_sep/dl2_misses
cat LOG_GO_SEP | grep il1.miss_rate > extract_sep/il1_miss_rate
cat LOG_GO_SEP | grep dl1.miss_rate > extract_sep/dl1_miss_rate
cat LOG_GO_SEP | grep il2.miss_rate > extract_sep/il2_miss_rate
cat LOG_GO_SEP | grep dl2.miss_rate > extract_sep/dl2_miss_rate
cat LOG_GO_SEP | grep il1.accesses > extract_sep/il1_accesses
cat LOG_GO_SEP | grep dl1.accesses > extract_sep/dl1_accesses
cat LOG_GO_SEP | grep il2.accesses > extract_sep/il2_accesses
cat LOG_GO_SEP | grep dl2.accesses > extract_sep/dl2_accesses
