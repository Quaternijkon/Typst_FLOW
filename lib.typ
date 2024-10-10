yes! it works!
#let llltable(titles:(),caption:[],align:left,kind:"table",supplement:[表],..items)={
  let items=items.pos()//在函数定义中，..bodies 表示接收任意数量的参数，这些参数被收集到一个特殊的 参数对象（arguments object） 中.bodies.pos() 方法从参数对象中提取所有的 位置参数，并返回一个 序列（sequence），即一个有序的参数列表。
  figure(
    kind:kind,
    supplement:supplement,
    caption: caption,
    table(
    stroke: none, 
    columns: titles.len(),
    align: align,
    table.hline(),
    table.header(
      for title in titles {
        [#strong(title)]
      }
    ),
    table.hline(),
    ..items,
    table.hline(),
    ),
  )
}

#let Ne=("Monaspace Neon")
#let NeW=("Monaspace Neon SemiWide")
#let NeI=("Monaspace Neon Var Italic")

#let Ar=("Monaspace Argon")
#let ArW=("Monaspace Argon SemiWide")
#let ArI=("Monaspace Argon Var Italic")

#let Xe=("Monaspace Xenon")
#let XeW=("Monaspace Xenon SemiWide")
#let XeI=("Monaspace Xenon Var Italic")

#let Rn=("Monaspace Radon")
#let RnW=("Monaspace Radon SemiWide")
#let RnI=("Monaspace Radon Var Italic")

#let Kr=("Monaspace Krypton")
#let KrW=("Monaspace Krypton SemiWide")
#let KrI=("Monaspace Krypton Var Italic")