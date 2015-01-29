#!/bin/bash

assoc_128_64=( 1 2 4 8 2048 )
#echo ${assoc_128_64[4]}
assoc_128_32=( 1 2 4 8 4096 )
assoc_1m_64=( 1 2 4 8 16384 )
assoc_1m_32=( 1 2 4 8 32768 )
sets_128_64=( 2048 1024 512 256 1 )
sets_128_32=( 4096 2048 1024 512 1 )
sets_1m_64=( 16384 8192 4096 2048 1 )
sets_1m_32=( 32768 16384 8192 4096 1 )
blk_size=( 64 32 )
replacement=( 'f' 'l' 'r' )

#res="./sim-cache -cache:dl1 dl1:"${sets_128_64[0]}":"${blk_size[0]}":"${assoc_128_64[0]}":"${replacement[0]}" -cache:il1 il1:"${sets_128_64[0]}":"${blk_size[0]}":"${assoc_128_64[0]}":"${replacement[0]}" -cache:dl2 dl2:"${sets_1m_64[0]}":"${blk_size[0]}":"${assoc_1m_64[0]}":"${replacement[0]}" -cache:il2 il2:"${sets_1m_64[0]}":"${blk_size[0]}":"${assoc_1m_64[0]}":"${replacement[0]}" -tlb:itlb none -tlb:dtlb none -redir:sim ../my_go_tmp benchmarks/cc1.alpha -O benchmarks/1stmt.i"
#eval $res

#For each value in blk_size, when blk_size is 64 for each value in replacement and for each value in assoc_128_64 run for each value of assoc_1m_64 and sets_1m_64
#The code below will handle only separate data and instruction cache

for blk in "${blk_size[@]}"
do
	#echo $blk
	for repl in "${replacement[@]}"
	do
		#echo $repl
		if [ $blk -eq 64 ]
		then
			set_counter1=0
			for assoc in "${assoc_128_64[@]}"
			do
				#echo $assoc
				#echo "set_counter1="$set_counter1
				#echo ${sets_128_64[$set_counter1]}
				#((set_counter1++))
				set_counter2=0
				for assoc2 in "${assoc_1m_64[@]}"
				do
					#echo $assoc2  --------> Add the command for 64 bit here
					#echo "set_counter2="$set_counter2
					#echo ${sets_1m_64[$set_counter2]}
					res="./sim-cache -cache:dl1 ul1:"${sets_128_64[$set_counter1]}":"$blk":"$assoc":"$repl" -cache:dl2 ul2:"${sets_1m_64[$set_counter2]}":"$blk":"$assoc2":"$repl" -tlb:itlb none -tlb:dtlb none -redir:sim ../my_go_tmp benchmarks/go.alpha 50 9 benchmarks/2stone9.in > OUT"
					eval $res
					#cat ../my_go_tmp >> ../LOG_GO_SEP
					echo "L1 Unified cache size 128KB Block-Size="$blk" Associativity="$assoc" No.of.Sets="${sets_128_64[$set_counter1]}" Replacement Policy="$repl" and L2 Unified Cache size 1MB Block-Size="$blk" Associativity="$assoc2" No.of.Sets="${sets_1m_64[$set_counter2]}" Replacement Policy="$repl"." >> ../LOG_GO_UNI
					grep "il1.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.accesses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.accesses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.accesses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					echo "" >> ../LOG_GO_UNI

					rm ../my_go_tmp
					((set_counter2++))
				done
				((set_counter1++))
			done
		else
			set_counter3=0
			for assoc in "${assoc_128_32[@]}"
			do
				#echo $assoc
				#echo "set_counter3="$set_counter3
				#echo ${sets_128_32[$set_counter3]}
				#((set_counter3++))
				set_counter4=0
				for assoc2 in "${assoc_1m_32[@]}"
				do 
					#echo $assoc2 -----------> Add the command for 32 bit here
					#echo "set_counter4="$set_counter4
					#echo ${sets_1m_32[$set_counter4]}
					res1="./sim-cache -cache:dl1 ul1:"${sets_128_32[$set_counter3]}":"$blk":"$assoc":"$repl" -cache:dl2 ul2:"${sets_1m_32[$set_counter4]}":"$blk":"$assoc2":"$repl" -tlb:itlb none -tlb:dtlb none -redir:sim ../my_go_tmp benchmarks/go.alpha 50 9 benchmarks/2stone9.in > OUT"
					eval $res1
					echo "L1 Unified cache size 128KB Block-Size="$blk" Associativity="$assoc" No.of.Sets="${sets_128_32[$set_counter3]}" Replacement Policy="$repl" and L2 Unified Cache size 1MB Block-Size="$blk" Associativity="$assoc2" No.of.Sets="${sets_1m_32[$set_counter4]}" Replacement Policy="$repl"." >> ../LOG_GO_UNI
					#cat ../my_go_tmp >> ../LOG_GO_SEP
					grep "il1.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.access" ../my_go_tmp >> ../LOG_GO_UNI
					grep "il1.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.hits" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.misses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.accesses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.accesses" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul1.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					grep "ul2.miss_rate" ../my_go_tmp >> ../LOG_GO_UNI
					echo "" >> ../LOG_GO_UNI

					rm ../my_go_tmp
					((set_counter4++))
				done
				((set_counter3++))
			done
		fi
	done
done

