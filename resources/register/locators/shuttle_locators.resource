*** Variables ***
# =============================================================================
# MEJ Robot Framework Tests - Shuttle Company Registration Locators
# =============================================================================
# Locators for Shuttle Company registration process.
# Structure: Page 1 (Personal) -> Page 3 (Business) - NO Page 2 (Languages)
# =============================================================================

# *** First page - Personal Information ***
${FIRST_PAGE_REGISTER_SH_NAME_INPUT}                           [name="Model.FirstName"]
${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}                      [name="Model.LastName"]
${FIRST_PAGE_REGISTER_SH_DIAL_DROPDOWN}                        [class="form-select form-input-select"] >> nth=0
${FIRST_PAGE_REGISTER_SH_PHONE_INPUT}                          //label[contains(text(), "Phone")]/preceding-sibling::input
${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}                          [name="Model.Email"]
${FIRST_PAGE_REGISTER_SH_PASSWORD_INPUT}                       [name="Model.Password"]
${FIRST_PAGE_REGISTER_SH_CONFIRMED_PASSWORD_INPUT}             [name="Model.ConfirmPassword"]
${FIRST_PAGE_REGISTER_SH_TERMS_OF_USE_CHECKBOX}                //input[@type="checkbox"][following-sibling::*[contains(text(), 'I agree with')]]
${FIRST_PAGE_REGISTER_SH_NEXT_BUTTON}                          [class="x-btn x-btn-primary"]

# *** Second page - SKIPPED for Shuttle Company ***
# Shuttle Company does NOT have Languages & Experience page like Driver
# Goes directly from Page 1 to Page 3

# *** Third page - Business Details ***
${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}                     [name="Model.CountryId"]
${THIRD_PAGE_REGISTER_SH_BUSINESS_NUMBER_INPUT}                [name="Model.IdentificationNumber"]
${THIRD_PAGE_REGISTER_SH_VAT_PAYER_CHECKBOX}                   css=label.form-check-label:has-text("I am the VAT Payer")
${THIRD_PAGE_REGISTER_SH_VAT_NUMBER_INPUT}                     [name="Model.VatNumber"]
${THIRD_PAGE_REGISTER_SH_BUSINESS_NAME_INPUT}                  [name="Model.BusinessName"]
${THIRD_PAGE_REGISTER_SH_BUSINESS_ADDRESS_INPUT}               [name="Model.BusinessStreet"]
${THIRD_PAGE_REGISTER_SH_BUSINESS_CITY_INPUT}                  [name="Model.BusinessCity"]
${THIRD_PAGE_REGISTER_SH_ZIP_CODE_INPUT}                       [name="Model.BusinessZipCode"]
${THIRD_PAGE_REGISTER_SH_IBAN_INPUT}                           [name="Model.IbanInEuro"]
${THIRD_PAGE_REGISTER_SH_BIC_INPUT}                            [name="Model.Bic"]
${THIRD_PAGE_REGISTER_SH_FINISH_BUTTON}                        [class="x-btn x-btn-primary"]

# *** Finish page - Verification ***
${REGISTER_SH_FINISH_PAGE_EMAIL_TEXTAREA}                      [class="notification-component alert alert-dismissible fade show alert-primary notification-component-visible"]
${REGISTER_SH_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}               Verification email was sent, check your email.
