#import "cv_zh.typ": *
#import "@preview/fontawesome:0.5.0": *

#let cvdata = yaml("main_zh.yml")

#let uservars = (
    headingfont: "Heiti SC",
    bodyfont: "Songti SC",
    fontsize: 10pt,
    linespacing: 6pt,
    showAddress: true,
    showNumber: true,
    headingsmallcaps: false
)

#let customrules(doc) = {
    set page(
        paper: "us-letter",
        number-align: center,
        margin: 1.25cm,
    )

    doc
}

#let cvinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)
    doc = customrules(doc)

    doc
}

#show: doc => cvinit(doc)

#cvheading(cvdata, uservars)
#cveducation(cvdata)
#cvawards(cvdata)
#cvcertificates(cvdata)
#cvwork(cvdata)
#cvpublications(cvdata)
#cvprojects(cvdata)
#cvaffiliations(cvdata)
#cvskills(cvdata)
#cvreferences(cvdata)
#endnote()
