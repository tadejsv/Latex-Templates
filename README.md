# $\LaTeX$ templates

Here I have templates for some commonly used document classes (lecture notes and problem sets for now). For each document class I create a class (`.cls`) file, which imports most needed packages and defines some document specific environments and commands. There is also a common `macros.sty` file, which hosts some common commands that are common across all document types (for example `\newcommand{\N}{\mathbb{N}}`).

The aim of all these templates is to create beautiful and functional document types, which cut down on unnecessary (boilerplate) code and long repetitive commands/

## Document types

Currently the following document types are available:
- Lecture notes: Builds on the normal article class, sets a nice font (Bitstream Charter) and defines colorful theorem environments and a custom color palette. The template document also contains some useful tips and tricks.
- Problem set: Builds on the notes class above, does not contain theorems, but modifies the title to be more space-efficient, and adds hideable solutions.

## Todo

In the near future, a class for slides will be added. This will be based on the metropolis class, with only minor modifications. Also, a common base class for notes and problem set should be created.