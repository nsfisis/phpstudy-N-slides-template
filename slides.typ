#import "@preview/touying:0.6.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/cjk-unbreak:0.2.0": remove-cjk-break-space, transform-childs
#import "setoka.typ": *

#show: codly-init.with()

#show: remove-cjk-break-space

#let plugin_tokenize_ja_uninitialized = plugin("plugins/tokenize-ja/tokenize-ja.wasm")
#let plugin_tokenize_ja = plugin.transition(plugin_tokenize_ja_uninitialized.init)

#let tokenize(s) = {
  cbor(plugin_tokenize_ja.tokenize(bytes(s)))
}

#let get-inner-str(e) = {
  if e.func() == text {
    if e.has("text") {
      e.text
    } else if e.has("body") {
      e.body
    } else {
      none
    }
  } else {
    none
  }
}

#let make-助詞-small(rest) = {
  rest = transform-childs(rest, make-助詞-small)
  if utils.is-sequence(rest) {
    for child in rest.children {
      let s = get-inner-str(child)
      if s != none {
        for t in tokenize(s) {
          if t.at(1) == "助詞" {
            [#set text(size: 0.9em);#t.at(0)]
          } else {
            t.at(0)
          }
        }
      } else {
        child
      }
    }
  } else {
    rest
  }
}

#show: make-助詞-small

#show: setoka-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [
      TODO
    ],
    subtitle: [PHP 勉強会\@東京 第 TODO 回],
    author: [nsfisis (いまむら)],
    date: datetime(year: TODO, month: TODO, day: TODO),
  ),
  config-common(preamble: {
    codly(
      fill: rgb("#eee"),
      lang-format: none,
      number-format: none,
      zebra-fill: none,
    )
  })
)

#set text(font: "Noto Sans CJK JP", lang: "ja")

#title-slide()

#about-slide()

TODO

---

#[
  #set align(center + horizon)

  ご静聴 \
  ありがとうございました
]
