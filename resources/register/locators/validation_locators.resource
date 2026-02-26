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
${REGISTER_PASSWORD_VALIDATION}           xpath=//*[contains(text(), "Passwords must be at least 6 characters") or contains(text(), "Passwords must have at least one non alphanumeric") or contains(text(), "Passwords must have at least one lowercase") or contains(text(), "Passwords must have at least one uppercase") or contains(text(), "Passwords must have at least one digit")]
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

# =============================================================================
# WHATSAPP VALIDATION LOCATORS
# =============================================================================

${REGISTER_WHATSAPP_CHECKBOX}                        css=label.form-check-label:has-text("Verify WhatsApp")
${REGISTER_WHATSAPP_PHONE_REQUIRED_MESSAGE}          css=em.hint.text-danger:has-text("Phone number must be filled in first")
${REGISTER_WHATSAPP_VERIFIED_MESSAGE}                css=em.hint.text-success:has-text("WhatsApp verified")
${REGISTER_WHATSAPP_NOT_VERIFIED_MESSAGE}            css=em.hint.text-danger:has-text("WhatsApp not verified")

# =============================================================================
# PHONE VALIDATION LOCATORS
# =============================================================================

${REGISTER_PHONE_INPUT}                              xpath=//label[contains(text(), "Phone")]/preceding-sibling::input
${REGISTER_PHONE_VALIDATION}                         css=[name="Model.Phone"] ~ .invalid-feedback
${REGISTER_PHONE_INVALID_STATE}                      css=[name="Model.Phone"].is-invalid
${MSG_PHONE_INVALID}                                 Invalid phone number: Please enter only the remaining digits of your phone number, e.g., 0123456789.

# =============================================================================
# EMAIL EXTENDED VALIDATION
# =============================================================================

${MSG_EMAIL_ALREADY_REGISTERED}                      User email is already registered.
${REGISTER_SERVER_ERROR_CONTAINER}                   css=.error-validation-message

# =============================================================================
# NAME VALIDATION - EXTENDED
# =============================================================================

${MSG_NAME_MIN_LETTERS}                              Name must contain at least two letters.

# =============================================================================
# PASSWORD VALIDATION - MISSING RULE
# =============================================================================

${MSG_PASSWORD_NO_DIGIT}                             Passwords must have at least one digit ('0'-'9').

# =============================================================================
# TERMS VALIDATION
# =============================================================================

${MSG_TERMS_NOT_ACCEPTED}                            Terms have to be accepted.

# =============================================================================
# VAT VALIDATION
# =============================================================================

${REGISTER_VAT_NUMBER_VALIDATION}                    css=[name="Model.VatNumber"] ~ .invalid-feedback
${REGISTER_VAT_NUMBER_INVALID_STATE}                 css=[name="Model.VatNumber"].is-invalid
${MSG_VAT_NUMBER_REQUIRED}                           Vat number is required.

# =============================================================================
# LANGUAGE VALIDATION (Driver Page 2)
# =============================================================================

${REGISTER_NATIVE_LANGUAGE_INVALID_STATE}            xpath=//label[contains(text(), "Native language")]/..//select.is-invalid
${REGISTER_ENGLISH_LEVEL_INVALID_STATE}              xpath=//label[contains(text(), "Level")]/..//select.is-invalid
${REGISTER_DRIVING_EXPERIENCE_INVALID_STATE}         xpath=//label[contains(text(), "Years of Driving Experience")]/..//select.is-invalid
