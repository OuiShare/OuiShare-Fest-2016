# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
OuiShareFest::Application.initialize!

NEGATIVE_CAPTCHA_SECRET = '882bd76adca0619b406f000ed38ddefa012e93f0b583112cf95e750d2fa669c850ef1aa95a5a09107dc3d62033ca9980d82fa62e002a5117ce1d434530aeac0f'
