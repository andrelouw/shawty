app_name := Shawty
ios_device := iPhone 14
ios_os := 16.4

.PHONY: bootstrap build run workspace module test_ios test_macos rename clean format lint

all: bootstrap run
ci: --ci-bootstrap clean workspace build test_macos test_ios
ci_macos: --ci-bootstrap clean workspace build test_macos
ci_ios: --ci-bootstrap clean workspace build test_ios
test: test_macos test_ios

bootstrap: --homebrew --mint --mint --hooks

rename:
	@./Scripts/rename.sh

build: --tuist
	@tuist build --clean

run: --tuist
	@tuist generate

edit: --tuist
	@tuist edit

workspace: --tuist
	@tuist generate --no-open

module: --tuist
	@./Scripts/module.sh

test_local: test_unit_ios test_unit_macos

test_ios: test_unit_ios test_integration_ios test_acceptance_ios

test_macos: test_unit_macos test_integration_macos

test_unit_ios:
	@set -o pipefail && xcodebuild test -workspace ${app_name}.xcworkspace -scheme "UnitTests-iOS" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -destination "platform=iOS Simulator,name=${ios_device},OS=${ios_os}" | mint run xcbeautify

test_unit_macos:
	@set -o pipefail && xcodebuild test -workspace ${app_name}.xcworkspace -scheme "UnitTests-macOS" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk macosx -destination "platform=macOS" | mint run xcbeautify

test_integration_ios:
	@set -o pipefail && xcodebuild test -workspace ${app_name}.xcworkspace -scheme "IntegrationTests-iOS" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -destination "platform=iOS Simulator,name=${ios_device},OS=${ios_os}" | mint run xcbeautify

test_integration_macos:
	@set -o pipefail && xcodebuild test -workspace ${app_name}.xcworkspace -scheme "IntegrationTests-macOS" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk macosx -destination "platform=macOS" | mint run xcbeautify

test_acceptance_ios:
	@set -o pipefail && xcodebuild test -workspace ${app_name}.xcworkspace -scheme "AcceptanceTests-iOS" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -destination "platform=iOS Simulator,name=${ios_device},OS=${ios_os}" | mint run xcbeautify

clean:
	@find . -name "*.xcodeproj" -type d -print0 | xargs -0 /bin/rm -r
	@find . -name "*.xcworkspace" -type d -print0 | xargs -0 /bin/rm -r

format:
	@./Scripts/format.sh

lint:
	@./Scripts/lint.sh

unbootstrap:
	@./Scripts/uninstall.sh

--homebrew:
	@./Scripts/homebrew.sh

--mint:
	@./Scripts/mint.sh

--tuist:
	@./Scripts/tuist.sh

--hooks:
	@./Scripts/hooks.sh

--ci-bootstrap: --mint --tuist
