# LearnHaskell - Chapter: 10. Functionally Solving Problems
## Calculator with the _Reverse Polish notation_ input

My first initial familiarized Haskell's project:
  * Develop in [Visual Studio Code](https://code.visualstudio.com/)
  * Manage with: [Stack, The Haskell Tool](https://www.haskellstack.org/)
  * And tests framework is: [Hspec](https://hspec.github.io/index.html)

----

How to start with this - on Windows:
  * Install `Stack`, via [Chocolatey](https://chocolatey.org/)
      - [`$ choco install haskell-stack`](https://chocolatey.org/packages/haskell-stack)
  * In a project's folder, execute commands:
      - `$ stack setup && stack test`
      - It could take a lot of time for the first time,
      - But there should be no _failures_, at the end of it.
  * If you would like to work on it in the VS Studio:
    - I advise you to install:
      [Haskero](https://marketplace.visualstudio.com/items?itemName=Vans.haskero),
      [haskell-linter](https://marketplace.visualstudio.com/items?itemName=hoovercj.haskell-linter).
    - Then, also execute a command:
    - `$ stack build intero hlint`
