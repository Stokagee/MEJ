*** Variables ***
# =============================================================================
# MEJ Robot Framework Tests - Registration Validation Locators
# =============================================================================
# Locators for registration form validation error messages.
# Uses Blazorise validation pattern: input ~ .invalid-feedback
# =============================================================================

# Blazorise validation CSS classes
${VALIDATION_INVALID_CLASS}           is-invalid
${VALIDATION_FEEDBACK_CLASS}          invalid-feedback
${VALIDATION_SUCCESS_CLASS}           valid-feedback

# *** First Page - Personal Information (Driver, Shuttle, Travel Agency) ***
${REGISTER_FIRST_NAME_VALIDATION}         css=[name="Model.FirstName"] ~ .invalid-feedback
${REGISTER_LAST_NAME_VALIDATION}          css=[name="Model.LastName"] ~ .invalid-feedback
${REGISTER_EMAIL_VALIDATION}              css=[name="Model.Email"] ~ .invalid-feedback
${REGISTER_PASSWORD_VALIDATION}           xpath=//*[contains(text(), "Passwords must be at least 6 characters") or contains(text(), "Passwords must have at least one non alphanumeric") or contains(text(), "Passwords must have at least one lowercase") or contains(text(), "Passwords must have at least one uppercase")]
${REGISTER_CONFIRM_PASSWORD_VALIDATION}   css=[name="Model.ConfirmPassword"] ~ .invalid-feedback

# Invalid state on inputs (has is-invalid class)
${REGISTER_FIRST_NAME_INVALID_STATE}      css=[name="Model.FirstName"].is-invalid
${REGISTER_LAST_NAME_INVALID_STATE}       css=[name="Model.LastName"].is-invalid
${REGISTER_EMAIL_INVALID_STATE}           css=[name="Model.Email"].is-invalid
${REGISTER_PASSWORD_INVALID_STATE}        css=[name="Model.Password"].is-invalid
${REGISTER_CONFIRM_PASSWORD_INVALID_STATE}    css=[name="Model.ConfirmPassword"].is-invalid

# *** Second Page - Languages (Driver only) ***
${REGISTER_ABOUT_ME_VALIDATION}           css=[name="Model.AboutMe"] ~ .invalid-feedback
${REGISTER_ABOUT_ME_INVALID_STATE}       css=[name="Model.AboutMe"].is-invalid

# *** Third Page - Business Details (Driver and Shuttle) ***
${REGISTER_BUSINESS_NUMBER_VALIDATION}    css=[name="Model.IdentificationNumber"] ~ .invalid-feedback
${REGISTER_ZIP_CODE_VALIDATION}           css=[name="Model.BusinessZipCode"] ~ .invalid-feedback
${REGISTER_IBAN_VALIDATION}               css=[name="Model.IbanInEuro"] ~ .invalid-feedback
${REGISTER_BIC_VALIDATION}                css=[name="Model.Bic"] ~ .invalid-feedback

# Invalid state on business inputs
${REGISTER_BUSINESS_NUMBER_INVALID_STATE}     css=[name="Model.IdentificationNumber"].is-invalid
${REGISTER_ZIP_CODE_INVALID_STATE}            css=[name="Model.BusinessZipCode"].is-invalid
${REGISTER_IBAN_INVALID_STATE}                css=[name="Model.IbanInEuro"].is-invalid
${REGISTER_BIC_INVALID_STATE}                 css=[name="Model.Bic"].is-invalid

# *** Expected Validation Messages ***
${MSG_NAME_MIN_LENGTH}                    Name must be at least two characters.
${MSG_EMAIL_INVALID}                      Invalid email address
${MSG_PASSWORD_MIN_LENGTH}                Passwords must be at least 6 characters.
${MSG_PASSWORD_NO_SPECIAL}                Passwords must have at least one non alphanumeric character.
${MSG_PASSWORD_NO_LOWERCASE}              Passwords must have at least one lowercase ('a'-'z').
${MSG_PASSWORD_NO_UPPERCASE}              Passwords must have at least one uppercase ('A'-'Z').
${MSG_PASSWORD_MISMATCH}                  'ConfirmPassword' and 'Password' do not match.
${MSG_ALPHANUMERIC_ONLY}                  Input can only contain letters (A-Z) and numbers (0-9).
${MSG_IBAN_INVALID}                       IBAN is not valid.
${MSG_BIC_INVALID}                        BIC is not valid.
