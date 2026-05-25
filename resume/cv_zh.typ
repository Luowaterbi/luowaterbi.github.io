#import "utils.typ"
#import "@preview/fontawesome:0.5.0": *

#let setrules(uservars, doc) = {
    set text(
        font: uservars.bodyfont,
        size: uservars.fontsize,
        hyphenate: false,
    )

    set list(
        spacing: uservars.linespacing
    )

    set par(
        leading: uservars.linespacing,
        justify: true,
    )

    doc
}

#let showrules(uservars, doc) = {
    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #set align(left)
        #set text(font: uservars.headingfont, size: 1em, weight: "bold")
        #it.body
        #v(-0.75em) #line(length: 100%, stroke: 1pt + black)
    ]

    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
        #it.body
        #v(2pt)
    ]

    doc
}

#let cvinit(doc) = {
    doc = setrules(doc)
    doc = showrules(doc)

    doc
}

#let addresstext(info, uservars) = {
    if uservars.showAddress {
        block(width: 100%)[
            #info.personal.location.city, #info.personal.location.region, #info.personal.location.country #info.personal.location.postalCode
            #v(-4pt)
        ]
    } else {none}
}

#let contacttext(info, uservars) = block(width: 100%)[
    #let profiles = (
        box(fa-at() + sym.space.en + link("mailto:" + info.personal.email)),
        if uservars.showNumber {box( fa-phone-alt() + sym.space.en + link("tel:" + info.personal.phone))} else {none},
        if info.personal.url != none {
            box(fa-globe() + sym.space.en + link(info.personal.url)[#info.personal.url.split("//").at(1)])
        }
    ).filter(it => it != none)

    #if info.personal.profiles.len() > 0 {
        for profile in info.personal.profiles {
            profiles.push(
                box(
                    if profile.icon == "github" [
                        #fa-github()
                    ] else if profile.icon == "google" [
                        #fa-google()
                    ] else if profile.icon == "linkedin" [
                        #fa-linkedin()
                    ] else if profile.icon == "twitter" [
                        #fa-twitter()
                    ] else if profile.icon == "weixin" [
                        #fa-weixin()
                    ] else [
                        #fa-globe()
                    ]
                    + sym.space.en + link(profile.url)[#profile.network]
                )
            )
        }
    }

    #set text(font: uservars.bodyfont, weight: "medium", size: uservars.fontsize * 1)
    #pad(x: 0em)[
        #profiles.join([#sym.space.en #sym.space.en])
    ]
]

#let cvheading(info, uservars) = {
    align(center)[
        = #info.personal.name
        #addresstext(info, uservars)
        #contacttext(info, uservars)
    ]
}

#let cvwork(info, isbreakable: true) = {
    if info.work != none {block[
        == 工作经历
        #for w in info.work {
            block(width: 100%, breakable: isbreakable)[
                #if w.url != none [
                    *#link(w.url)[#w.organization]* #h(1fr) *#w.location* \
                ] else [
                    *#w.organization* #h(1fr) *#w.location* \
                ]
            ]
            let index = 0
            for p in w.positions {
                if index != 0 {v(0.6em)}
                block(width: 100%, breakable: isbreakable, above: 0.6em)[
                    #let start = utils.strpdate(p.startDate)
                    #let end = utils.strpdate(p.endDate)
                    #text(style: "italic")[#eval(p.position, mode: "markup")] #h(1fr)
                    #start #sym.dash.en #end \
                    #for hi in p.highlights [
                        - #eval(hi, mode: "markup")
                    ]
                ]
                index = index + 1
            }
        }
    ]}
}

#let cveducation(info, isbreakable: true) = {
    if info.education != none {block[
        == 教育背景
        #for edu in info.education {
            let start = utils.strpdate(edu.startDate)
            let end = utils.strpdate(edu.endDate)

            let edu-items = ""
            if edu.honors != none {edu-items = edu-items + "- *荣誉*: " + edu.honors.join(", ") + "\n"}
            if edu.courses != none {edu-items = edu-items + "- *课程*: " + edu.courses.join(", ") + "\n"}
            if edu.highlights != none {
                for hi in edu.highlights {
                    edu-items = edu-items + "- " + hi + "\n"
                }
                edu-items = edu-items.trim("\n")
            }

            block(width: 100%, breakable: isbreakable)[
                #if edu.url != none [
                    *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
                ] else [
                    *#edu.institution* #h(1fr) *#edu.location* \
                ]
                #text(style: "italic")[#edu.studyType，#eval(edu.area, mode: "markup")]
                #h(1fr)
                #start #sym.dash.en #end \
                #if edu.supervisor != none [
                    #text(style: "italic")[*导师：* #eval(edu.supervisor, mode: "markup")]
                ] else {none}
                #eval(edu-items, mode: "markup")
            ]
        }
    ]}
}

#let cvaffiliations(info, isbreakable: true) = {
    if info.affiliations != none {block[
        == 社会活动
        #for org in info.affiliations {
            let start = utils.strpdate(org.startDate)
            let end = utils.strpdate(org.endDate)

            block(width: 100%, breakable: isbreakable)[
                #if org.url != none [
                    *#link(org.url)[#org.organization]* #h(1fr) *#org.location* \
                ] else [
                    *#org.organization* #h(1fr) *#org.location* \
                ]
                #text(style: "italic")[#org.position] #h(1fr)
                #start #sym.dash.en #end \
                #if org.highlights != none {
                    for hi in org.highlights [
                        - #eval(hi, mode: "markup")
                    ]
                } else {}
            ]
        }
    ]}
}

#let github(fork,star) = {
      if fork != none and star != none {
        [| #fa-github() #fa-code-branch() #fork #fa-star() #star]
      } else {}
}

#let cvprojects(info, isbreakable: true) = {
    if info.projects != none {block[
        == 项目经历
        #for project in info.projects {
            let start = utils.strpdate(project.startDate)
            let end = utils.strpdate(project.endDate)
            block(width: 100%, breakable: isbreakable)[
                #if project.url != none [
                    *#link(project.url)[#project.name #github(project.at("fork", default: none), project.at("star", default: none))]* #h(1fr) #start #sym.dash.en #end \
                ] else [
                    *#project.name*  #h(1fr) #start #sym.dash.en #end\
                ]
                #if project.highlights != none [
                  #for hi in project.highlights [
                    - #eval(hi, mode: "markup")
                 ]
                ]
            ]
        }
    ]}
}

#let cvawards(info, isbreakable: true) = {
    if info.awards != none {block[
        == 荣誉奖项
        #for award in info.awards {
            let date = utils.strpdate(award.date)
            block(width: 100%, breakable: isbreakable)[
                #if award.url != none [
                    *#link(award.url)[#award.title]* #h(1fr) *#award.location* \
                ] else [
                    *#award.title* #h(1fr) *#award.location* \
                ]
                颁发机构：#text(style: "italic")[#award.issuer]  #h(1fr) #date \
                #if award.highlights != none {
                    for hi in award.highlights [
                        - #eval(hi, mode: "markup")
                    ]
                } else {}
            ]
        }
    ]}
}

#let cvcertificates(info, isbreakable: true) = {
    if info.certificates != none {block[
        == 资格证书

        #for cert in info.certificates {
            let date = utils.strpdate(cert.date)
            block(width: 100%, breakable: isbreakable)[
                #if cert.url != none [
                    *#link(cert.url)[#cert.name]* \
                ] else [
                    *#cert.name* \
                ]
                颁发机构：#text(style: "italic")[#cert.issuer]  #h(1fr) #date \
            ]
        }
    ]}
}

#let cvpublications(info, isbreakable: true) = {
    if info.publications != none {
        let is-first-author(pub) = {
            let first = pub.authors.at(0)
            if first.starts-with("*Xianzhen Luo") {
                true
            } else {
                pub.authors.find(a => a.contains("Xianzhen Luo") and a.contains("super")) != none
            }
        }

        let format-conference(conf) = {
            let clean-conf = conf.replace("[Outstanding Paper]", "").replace("[Oral]", "").replace("[Spotlight]", "").trim()
            if clean-conf.contains("ACL") or clean-conf.contains("EMNLP") or clean-conf.contains("NAACL") [
                #box(baseline: 0%, fill: red.lighten(92%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: red.darken(20%), weight: "semibold", size: 0.95em)[#clean-conf]])
            ] else if clean-conf.contains("KDD") or clean-conf.contains("ICML") or clean-conf.contains("NeurIPS") or clean-conf.contains("ICLR") [
                #box(baseline: 0%, fill: green.lighten(92%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: green.darken(40%), weight: "semibold", size: 0.95em)[#clean-conf]])
            ] else if clean-conf.contains("COLING") or clean-conf.contains("LREC") [
                #box(baseline: 0%, fill: teal.lighten(92%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: teal.darken(40%), weight: "semibold", size: 0.95em)[#clean-conf]])
            ] else if clean-conf.contains("Arxiv") or clean-conf.contains("Preprint") [
                #box(baseline: 0%, fill: gray.lighten(90%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: gray.darken(30%), style: "italic", size: 0.95em)[#clean-conf]])
            ] else if clean-conf.contains("Tech Report") or clean-conf.contains("Survey") [
                #box(baseline: 0%, fill: purple.lighten(92%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: purple.darken(30%), weight: "semibold", size: 0.95em)[#clean-conf]])
            ] else if clean-conf.contains("AI Open") [
                #box(baseline: 0%, fill: aqua.lighten(92%), inset: (x: 2pt, y: 0.5pt), radius: 2pt,
                    [#text(fill: aqua.darken(40%), weight: "semibold", size: 0.95em)[#clean-conf]])
            ] else [
                #text(weight: "medium", size: 0.95em)[#clean-conf]
            ]
        }

        let render-title(pub) = {
            if pub.url != none [
                #if pub.publisher.contains("[Outstanding Paper]") [
                    #box(baseline: 20%, fill: gradient.linear(red.lighten(88%), orange.lighten(90%)),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[🏆] #text(fill: gradient.linear(red.darken(10%), orange.darken(10%)), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Outstanding Paper]", "").trim() Outstanding Paper]]
                    ) *#link(pub.url)[#pub.name]* \
                ] else if pub.publisher.contains("[Spotlight]") [
                    #box(baseline: 20%, fill: yellow.lighten(85%),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[⭐] #text(fill: orange.darken(20%), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Spotlight]", "").trim() Spotlight]]
                    ) *#link(pub.url)[#pub.name]* \
                ] else if pub.publisher.contains("[Oral]") [
                    #box(baseline: 20%, fill: blue.lighten(92%),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[📢] #text(fill: blue.darken(30%), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Oral]", "").trim() Oral]]
                    ) *#link(pub.url)[#pub.name]* \
                ] else [
                    #format-conference(pub.publisher) *#link(pub.url)[#pub.name]* \
                ]
            ] else [
                #if pub.publisher.contains("[Outstanding Paper]") [
                    #box(baseline: 20%, fill: gradient.linear(red.lighten(88%), orange.lighten(90%)),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[🏆] #text(fill: gradient.linear(red.darken(10%), orange.darken(10%)), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Outstanding Paper]", "").trim() Outstanding Paper]]
                    ) *#pub.name* \
                ] else if pub.publisher.contains("[Spotlight]") [
                    #box(baseline: 20%, fill: yellow.lighten(85%),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[⭐] #text(fill: orange.darken(20%), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Spotlight]", "").trim() Spotlight]]
                    ) *#pub.name* \
                ] else if pub.publisher.contains("[Oral]") [
                    #box(baseline: 25%, fill: blue.lighten(92%),
                        inset: (x: 5pt, top: 0.5pt, bottom: 3pt), radius: 2pt,
                        [#text(size: 0.75em)[📢] #text(fill: blue.darken(30%), weight: "bold", size: 0.95em)[#pub.publisher.replace("[Oral]", "").trim() Oral]]
                    ) *#pub.name* \
                ] else [
                    #format-conference(pub.publisher) *#pub.name* \
                ]
            ]
        }

        let first-pubs = info.publications.filter(pub => is-first-author(pub))
        let other-pubs = info.publications.filter(pub => not is-first-author(pub))

        if first-pubs.len() > 0 {block[
            == 一作论文
            #for pub in first-pubs {
                let date = if pub.releaseDate != none [
                    #utils.strpdate(pub.releaseDate)
                ] else [
                    #pub.releaseDate
                ]
                block(width: 100%, breakable: isbreakable)[
                    #render-title(pub)
                    #text(style: "italic")[#pub.authors.map((a,) => eval(a, mode: "markup")).join(", ")] #h(1fr) #date \
                    #if pub.highlights != none {
                        for hi in pub.highlights [
                            - #eval(hi, mode: "markup")
                        ]
                    } else {}
                ]
            }
        ]}

        if other-pubs.len() > 0 {block[
            == 其他论文
            #for pub in other-pubs {
                let date = if pub.releaseDate != none [
                    #utils.strpdate(pub.releaseDate)
                ] else [
                    #pub.releaseDate
                ]
                block(width: 100%, breakable: isbreakable)[
                    #render-title(pub)
                    #text(style: "italic")[#pub.authors.map((a,) => eval(a, mode: "markup")).join(", ")] #h(1fr) #date \
                ]
            }
        ]}
    }
}

#let cvskills(info, isbreakable: true) = {
    if (info.languages != none) or (info.skills != none) or (info.interests != none) {block(breakable: isbreakable)[
        == 技能与兴趣
        #if (info.languages != none) [
            #let langs = ()
            #for lang in info.languages {
                langs.push([#lang.language (#lang.fluency)])
            }
            - *语言*: #langs.join(", ")
        ]
        #if (info.skills != none) [
            #for group in info.skills [
                - *#group.category*: #group.skills.join(", ")
            ]
        ]
        #if (info.interests != none) [
            - *兴趣*: #info.interests.join(", ")
        ]
    ]}
}

#let cvreferences(info, isbreakable: true) = {
    if info.references != none {block[
        == 推荐人
        #for ref in info.references {
            block(width: 100%, breakable: isbreakable)[
                #if ref.url != none [
                    - *#link(ref.url)[#ref.name]*: "#ref.reference"
                ] else [
                    - *#ref.name*: "#ref.reference"
                ]
            ]
        }
    ]} else {}
}

#let endnote() = {
    place(
        bottom + right,
        block[
            #set text(size: 5pt, font: "PingFang SC", fill: silver)
            \*本文档最后更新于 #datetime.today().display("[year]-[month]-[day]")，使用 #link("https://typst.app")[Typst] 排版。
        ]
    )
}
