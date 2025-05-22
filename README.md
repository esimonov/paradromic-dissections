# Paradromic rings dissections

The main goal of the project was to explore Scheme's capabilities as a general purpose programming language.
The idea for a subject was inspired by Dr Tasashi Tokieda's course [Topology & Geometry](https://youtu.be/SXHHvoaSctc?si=9bXOmKjzHKfTlmgv).

## Why?

Some surprising properties show up when dissecting Möbius strips and similar structures.

>A mathematician confided
>That a Mobius band is one-sided,
>And you'll get quite a laugh,
>If you cut one in half,
>For it stays in one piece when divided.

![Cut along the centerline](/assets/Moebiusband-1s.svg)

When the strip is dissected off-center instead, the result may seem even stranger:

![Off-center cut](/assets/Moebiusband-2s.svg)

Original image sources:

* [Cut along the centerline](https://commons.wikimedia.org/wiki/File:Moebiusband-1s.svg)
* [Off-center cut](https://commons.wikimedia.org/wiki/File:Moebiusband-2s.svg)

Let's use the CLI to verify what we've just seen!

```text
Enter the number of initial half-twists (or 'q' to quit) : 1
Enter D>=2 to mark the line 1/D along which the strip will be dissected (or 'q' to quit) : 2
---------
When dissecting a strip with 1 half-twist of length L 1/2 way across its width, you get a single connected strip which is 2 times longer and slimmer and than the original one:

Length: 2L
Number of half-twists: 4


---------

Enter the number of initial half-twists (or 'q' to quit) : 1
Enter D>=2 to mark the line 1/D along which the strip will be dissected (or 'q' to quit) : 3
---------
When dissecting a strip with 1 half-twist of length L 1/3 way across its width, you get two linked strips, one of which is twice as long as the other:

Strip #1
Length: 2L
Number of half-twists: 4

Strip #2
Length: L
Number of half-twists: 1



---------

Enter the number of initial half-twists (or 'q' to quit) : q
Goodbye!
```
