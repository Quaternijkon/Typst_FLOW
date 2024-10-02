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
    title: [Some Optimization Strategies in Milvus],
    subtitle: [Heterogeneous Computing],
    author: [董若扬],
    date: datetime.today(),
    institution: [ADSLAB, USTC],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// #outline-slide()

#include "content.typ"

