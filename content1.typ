#import "src/exports.typ": *

#import "theme.typ": *

= #smallcaps("Introduction")

== Problem

给定一个包含 $m$ 个查询 ${q_1, q_2, ..., q_m}$ 的集合和一个包含 $n$ 个数据向量 ${v_1, v_2, ..., v_n}$ 的集合，如何快速为每个查询 $q_i$ 找到其最相似的前 $k$ 个向量？

#line(length: 100%)

#side-by-side()[
  *最相似的向量*

可以通过欧几里得距离或者余弦角来量化相似程度。
][
#figure(
  image("img/qv.svg", width: 70%)
  
)
]

== Before Search

在开始搜索之前，还需要对数据库中的向量创建索引以加快搜索过程。创建索引的方法有基于量化的方法和基于图的方法。相较于基于图的索引，在取得较好结果的情况下，基于量化的索引占用更少的内存，并且运行速度更快。

#side-by-side()[

*索引创建过程*

使用K-means 聚类算法构建码本（其中每个码字是一个质心），应用量化器将向量映射到码字上，码字是距离向量最近的质心。
][
  #figure(
    image("img/index1.svg", width: 80%)
  )
]

== Filter

#side-by-side()[
根据查询  $q$  和每个桶质心 $c$ 之间的距离，找到最近的  $n_"probe"$  个桶。例如，$n_"probe"=2$ ，则每个查询会在所有聚类中找到质心离自己最近的两个。

参数  $n_"probe"$  控制准确性和性能之间的权衡。较大的  $n_"probe"$  值可以产生更高的准确性，但性能可能会下降。
][
  #figure(
    image("img/index.svg", width: 70%)
  )
]

== Thread Model

#side-by-side()[
查询进程 $P$ 中有多个线程 $T_i$ 并行执行，每个线程 $T_i$ 都有自己的堆栈，这些堆栈中的内容存放在内存中，并受操作系统的调度放进Cache里。
][
  #figure(
    image("img/thread.svg", width: 80%)
  )
]

= #smallcaps("Faiss Solution")

== Solution

#side-by-side()[
Faiss 使用 OpenMP 多线程并行处理查询。

Faiss将查询向量 $q_i$ 放进线程中，将待比较的数据向量 $v_i$ 放进cache

当 $q_i$ 完成当前cache数据查询后，切换下一页数据向量 $v$ 进入cache，直到 $q_i$ 查询完所有数据向量，释放当前线程，进行下一个查询。
 


][
  #figure(
    image("img/faiss.svg", width: 75%)
  )  
]

== Cost

  #side-by-side()[
=== Problem

对于每个查询，整个数据集需要完整地流式通过cache，无法在下一个查询中复用。

$m$ :number of queries; 

$t$ :number of threads.


每个线程都需要读取m/t次完整的数据。
  ][
  #figure(
    image("img/faiss.svg", width: 75%)
  )      
  ]


= #smallcaps("Milvus Solution")

== Solution

#side-by-side()[
Milvus将数据向量 $v_i$ 放入线程中，将查询向量 $q_i$ 放进cache

Milvus 使用*多线程*同时计算每个*查询块*的 top-k 结果。每个线程将其分配的数据向量与缓存中的整个查询块（含有 s 个查询）进行比较。

为了最小化同步开销，Milvus 为*每个线程*分配一个查询堆。查询 $q_i$ 的结果分布在 $t$ 个线程的堆中。最后，需要合并各线程的堆来得到最终的 top-k 结果。

][
  #figure(
    image("img/milvus.svg", width: 79.5%)
  )      
]

== Calculat s

$ s=("L3's cache size")/(d times "sizeof(float)" + t times k times ("sizeof(int64)"+"sizeof(float)")) $

  #figure(
    image("img/calc_s.svg", width: 90%)
  ) 

== Cost

