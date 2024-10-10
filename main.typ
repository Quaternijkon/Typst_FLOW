// #import "../lib.typ": *
#import "theme.typ": *
// #import "src/exports.typ": *
// #import themes.dewdrop: *

#import "@preview/numbly:0.1.0": numbly

#show: dewdrop-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.title,
  footer-alt: self => self.info.subtitle,
  navigation: "mini-slides",
  config-info(
    title: [A strategy to improve cache performance in vevtor search],
    subtitle: [Cache-aware design in Milvus],
    author: [董若扬],
    date: datetime.today(),
    institution: [ADSLAB, USTC],
  ),
)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#let primary= rgb("#004098")

#show emph: it => {
  text(primary, it.body)
}

#show outline.entry.where(
  level: 1
): it => {
  v(1em, weak: true)
  // strong(it.body)
  text(primary, it.body)
}



#title-slide()

// #outline-slide()

#include "content1.typ"

