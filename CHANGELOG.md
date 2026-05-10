# Changelog

## [0.1.1](https://github.com/pabloqr/sportying-app/compare/v0.1.0...v0.1.1) (2026-05-10)


### Refactors

* **auth:** encapsulate local auth state management in AuthRepository ([3d0c78d](https://github.com/pabloqr/sportying-app/commit/3d0c78dbb31d1c286cf0f9734fc69d48ea0fec53))
* **auth:** implement role-based routing and update user state management ([f8e902d](https://github.com/pabloqr/sportying-app/commit/f8e902d6f41d4850cee78762d4920098bc22dbf2))
* **auth:** improve authentication state management and result handling ([5726b12](https://github.com/pabloqr/sportying-app/commit/5726b12511b8900baa6536600a67ccb852381e08))
* **core:** rename utility files from utilities to utils ([b791dc5](https://github.com/pabloqr/sportying-app/commit/b791dc575dacbb18a00230d342cd6fd3f20aa356))
* implement data mappers and remove JSON logic from domain models ([0bed129](https://github.com/pabloqr/sportying-app/commit/0bed12961f50ccf1e843911a8780b40174d5cbbf))
* improve code analysis options and linting rules ([4c76c57](https://github.com/pabloqr/sportying-app/commit/4c76c57fb18e393330cea1d6db04b185b49370c6))
* remove freezer generated files from repository ([b56476b](https://github.com/pabloqr/sportying-app/commit/b56476bd999d6c858ab4f342596b93dc0a538d07))
* rename Routes to AppRoutes and introduce ServerRoutes ([21cdef0](https://github.com/pabloqr/sportying-app/commit/21cdef043537f5471c3a0546438924fcaf71e1f7))
* reorganize client files to match Flutter MVVM pattern ([705390f](https://github.com/pabloqr/sportying-app/commit/705390fa61de3fa3f3486d56a27042dd2bccfdb6))
* reorganize remote services and rename models to DTOs ([510b435](https://github.com/pabloqr/sportying-app/commit/510b435c6328f9ed344b39245469372b20b1e853))
* **routing:** improve authentication and dashboard redirection logic ([15b9d3d](https://github.com/pabloqr/sportying-app/commit/15b9d3d35378dbfd3e7c7eec70e78a8fac7cdfc7))


### Documentation

* **utils:** add documentation and Command2 to command utility ([4cfc1db](https://github.com/pabloqr/sportying-app/commit/4cfc1dbb0a026546bfdac0766c7fd605c76c2dc6))


### CI/CD

* add code generation step to workflows ([18ab0f6](https://github.com/pabloqr/sportying-app/commit/18ab0f6faefb70591fe5b6611a6f5395d60d3a80))
* add sbom.yaml generation to CI workflows ([32209c0](https://github.com/pabloqr/sportying-app/commit/32209c021f12c98893fbb9ea41f965c08cf0e483))
* add step to list generated files ([a176fa5](https://github.com/pabloqr/sportying-app/commit/a176fa53fe57904dd15f3a406056add12cd32311))
* configure CI/CD pipelines and release automation ([9aaf500](https://github.com/pabloqr/sportying-app/commit/9aaf50086732397eaf8a1df72afd0fcaf6c793fa))
* disable snyk security scanning jobs ([6756599](https://github.com/pabloqr/sportying-app/commit/67565999e42ba31191a1c9a0a5e5698e2da187e1))
* integrate SBOM generation and update Snyk scanning targets ([9e339d8](https://github.com/pabloqr/sportying-app/commit/9e339d816b1ccc073113f3df41c7ef23b740fa11))
* replace manual SBOM generation with sbomify-action, add security-events permissions and cleanup ([b467949](https://github.com/pabloqr/sportying-app/commit/b4679497577033806d2ef190d9e0d5a7a1f53d96))
* switch to sbomify-action for SBOM generation ([911ed5c](https://github.com/pabloqr/sportying-app/commit/911ed5c50b94d8c76fe0a188e25e265259a3d038))
* update Snyk SBOM test file to sbom.spdx ([309807b](https://github.com/pabloqr/sportying-app/commit/309807bbeeacb5ce9fcc710e542be1724972aeca))
