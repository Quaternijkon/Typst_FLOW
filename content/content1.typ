#import "./../theme.typ": *
#import "./../lib.typ"

#import "@preview/numbly:0.1.0": numbly

#show: dewdrop-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.title,
  footer-alt: self => self.info.subtitle,
  navigation: "mini-slides",
  config-info(
    title: [传统派与改革派之争],
    subtitle: [谈尼古丁真与芙蓉王源],
    author: [丁真珍珠],
    date: datetime.today(),
    institution: [甘孜，理塘],
  ),
)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#let primary= rgb("#004098")

#show emph: it => {  
  underline(stroke: (thickness: 1em, paint: primary.transparentize(80%), cap: "round"),offset: -7pt,background: true,evade: false,extent: -8pt,text(primary, it.body))
}

#show outline.entry.where(
  level: 1
): it => {
  v(1em, weak: true)
  // strong(it.body)
  text(primary, it.body)
}

#title-slide()
//以下是正文