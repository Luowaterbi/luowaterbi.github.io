#import "utils.typ"
#import "@preview/fontawesome:0.5.0": *

// set rules
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

// show rules
#let showrules(uservars, doc) = {
    // uppercase section headings
    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #set align(left)
        #set text(font: uservars.headingfont, size: 1em, weight: "bold")
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // draw a line
    ]

    // name title
    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(2pt)
    ]

    doc
}

// set page layout
#let cvinit(doc) = {
    doc = setrules(doc)
    doc = showrules(doc)

    doc
}

// address
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
            box(link(info.personal.url)[#info.personal.url.split("//").at(1)])
        }
    ).filter(it => it != none) // filter out none elements from the profile array

    // #fa-icon("github", fa-set: "Brands")
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
        == Experience
        #for w in info.work {
            block(width: 100%, breakable: isbreakable)[
                // line 1: company and location
                #if w.url != none [
                    *#link(w.url)[#w.organization]* #h(1fr) *#w.location* \
                ] else [
                    *#w.organization* #h(1fr) *#w.location* \
                ]
            ]
            // create a block layout for each work entry
            let index = 0
            for p in w.positions {
                if index != 0 {v(0.6em)}
                block(width: 100%, breakable: isbreakable, above: 0.6em)[
                    // parse ISO date strings into datetime objects
                    #let start = utils.strpdate(p.startDate)
                    #let end = utils.strpdate(p.endDate)
                    // line 2: position and date range
                    #text(style: "italic")[#eval(p.position, mode: "markup")] #h(1fr)
                    #start #sym.dash.en #end \
                    // highlights or description
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
        == Education
        #for edu in info.education {
            let start = utils.strpdate(edu.startDate)
            let end = utils.strpdate(edu.endDate)

            let edu-items = ""
            if edu.honors != none {edu-items = edu-items + "- *Honors*: " + edu.honors.join(", ") + "\n"}
            if edu.courses != none {edu-items = edu-items + "- *Courses*: " + edu.courses.join(", ") + "\n"}
            if edu.highlights != none {
                for hi in edu.highlights {
                    edu-items = edu-items + "- " + hi + "\n"
                }
                edu-items = edu-items.trim("\n")
            }

            // create a block layout for each education entry
            block(width: 100%, breakable: isbreakable)[
                // line 1: institution and location
                #if edu.url != none [
                    *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
                ] else [
                    *#edu.institution* #h(1fr) *#edu.location* \
                ]
                // line 2: degree and date
                #text(style: "italic")[#edu.studyType in #eval(edu.area, mode: "markup")] 
                #h(1fr)
                #start #sym.dash.en #end \
                #if edu.supervisor != none [
                    #text(style: "italic")[*Supervisor:* #eval(edu.supervisor, mode: "markup")]
                ] else {none}
                #eval(edu-items, mode: "markup")
            ]
        }
    ]}
}

#let cvaffiliations(info, isbreakable: true) = {
    if info.affiliations != none {block[
        == Leadership & Activities
        #for org in info.affiliations {
            // parse ISO date strings into datetime objects
            let start = utils.strpdate(org.startDate)
            let end = utils.strpdate(org.endDate)

            // create a block layout for each affiliation entry
            block(width: 100%, breakable: isbreakable)[
                // line 1: organization and location
                #if org.url != none [
                    *#link(org.url)[#org.organization]* #h(1fr) *#org.location* \
                ] else [
                    *#org.organization* #h(1fr) *#org.location* \
                ]
                // line 2: position and date
                #text(style: "italic")[#org.position] #h(1fr)
                #start #sym.dash.en #end \
                // highlights or description
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
        == Projects
        #for project in info.projects {
            // parse ISO date strings into datetime objects
            let start = utils.strpdate(project.startDate)
            let end = utils.strpdate(project.endDate)
            // create a block layout for each project entry
            block(width: 100%, breakable: isbreakable)[
                // line 1: project name and date
                #if project.url != none [
                    *#link(project.url)[#project.name #github(project.at("fork", default: none), project.at("star", default: none))]* #h(1fr) #start #sym.dash.en #end \
                ] else [
                    *#project.name*  #h(1fr) #start #sym.dash.en #end\
                ]
                // line 2: organization 
                // #text(style: "italic")[#project.affiliation] \
                // summary or description
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
        == Honors & Awards
        #for award in info.awards {
            // parse ISO date strings into datetime objects
            let date = utils.strpdate(award.date)
            // create a block layout for each award entry
            block(width: 100%, breakable: isbreakable)[
                // line 1: award title and location
                #if award.url != none [
                    *#link(award.url)[#award.title]* #h(1fr) *#award.location* \
                ] else [
                    *#award.title* #h(1fr) *#award.location* \
                ]
                // line 2: issuer and date
                Issued by #text(style: "italic")[#award.issuer]  #h(1fr) #date \
                // summary or description
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
        == Licenses & Certifications

        #for cert in info.certificates {
            // parse ISO date strings into datetime objects
            let date = utils.strpdate(cert.date)
            // create a block layout for each certificate entry
            block(width: 100%, breakable: isbreakable)[
                // line 1: certificate name
                #if cert.url != none [
                    *#link(cert.url)[#cert.name]* \
                ] else [
                    *#cert.name* \
                ]
                // line 2: issuer and date
                Issued by #text(style: "italic")[#cert.issuer]  #h(1fr) #date \
            ]
        }
    ]}
}

#let cvpublications(info, isbreakable: true) = {
    if info.publications != none {
        // Helper: check if a publication is first/co-first authored by Xianzhen Luo
        let is-first-author(pub) = {
            let first = pub.authors.at(0)
            if first.starts-with("*Xianzhen Luo") {
                true
            } else {
                // Check for co-first author marker
                pub.authors.find(a => a.contains("Xianzhen Luo") and a.contains("super")) != none
            }
        }

        // Helper: format conference badge
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

        // Helper: render the conference badge + title line
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

        // Split publications into first-author and other
        let first-pubs = info.publications.filter(pub => is-first-author(pub))
        let other-pubs = info.publications.filter(pub => not is-first-author(pub))

        // === First-author Publications ===
        if first-pubs.len() > 0 {block[
            == First-author Publications
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

        // === Other Publications ===
        if other-pubs.len() > 0 {block[
            == Other Publications
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
        == Skills, Languages, Interests
        #if (info.languages != none) [
            #let langs = ()
            #for lang in info.languages {
                langs.push([#lang.language (#lang.fluency)])
            }
            - *Languages*: #langs.join(", ")
        ]
        #if (info.skills != none) [
            #for group in info.skills [
                - *#group.category*: #group.skills.join(", ")
            ]
        ]
        #if (info.interests != none) [
            - *Interests*: #info.interests.join(", ")
        ]
    ]}
}

#let cvreferences(info, isbreakable: true) = {
    if info.references != none {block[
        == References
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
            #set text(size: 5pt, font: "Consolas", fill: silver)
            \*This document was last updated on #datetime.today().display("[year]-[month]-[day]") using #link("https://typst.app")[Typst].
        ]
    )
}
