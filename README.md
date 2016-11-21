# TWTL

응 답없음

이 Git 저장소는 GitHub Repository [TWTL/Build][1]의 사본으로, 개발 저장소들을 통합해서 빌드, 패키지 및 제출 등의 관리를 수행하기 위해 만들어졌습니다.

## Git 저장소 스냅샷

개발 저장소들의 목록은 다음과 같습니다.

* [TWTL/Documentation][2]
* [TWTL/Engine][3]
* [TWTL/GUI][4]
* [TWTL/Service][5]
* [TWTL/TestSuite][6]

각 저장소의 스냅샷이 Git submodule로 만들어져 있습니다.

프로젝트 문서는 문서화 저장소 TWTL/Documentation (Documentation 폴더) 에서 찾을 수 있습니다. 문서화에 대한 설명은 TWTL Doc 001 (Documentation/001-index/README.md) 를, 각 저장소에 대한 설명은 TWTL Doc 002 (Documentation/002-index/README.md) 를 참조하십시오.

[1]: https://github.com/TWTL/Build
[2]: https://github.com/TWTL/Documentation
[3]: https://github.com/TWTL/Engine
[4]: https://github.com/TWTL/GUI
[5]: https://github.com/TWTL/Service
[6]: https://github.com/TWTL/TestSuite

## 빌드

저장소 스냅샷은 통합된 빌드와 패키징에 쓰입니다.

Git submodule은 리비전에 대한 참조이기 때문에 QA 담당이 빌드 상태와 함께 대상 리비전을 기록하는 용도로 쓰이며, 소스코드를 제출하기 위해서도 쓰입니다.

이 저장소의 주 기능으로, NSIS 3.0 스크립트를 이용해 빌드된 바이너리를 묶어 인스톨러를 만들고 이 인스톨러는 테스트 VM에 쓰였습니다. 자세한 것은 TWTL Doc 013 (Documentation/013-install/README.md) 을 참조하십시오.
