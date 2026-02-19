*** Variables ***
# *** First page ***
${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}                           [name="Model.FirstName"]
${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}                      [name="Model.LastName"]
${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}                        [class="form-select form-input-select"] >> nth=0
${FIRST_PAGE_REGISTER_DRIVER_PHONE_INPUT}                          //label[contains(text(), "Phone")]/preceding-sibling::input
${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}                          [name="Model.Email"]
${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}                       [name="Model.Password"]
${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}             [name="Model.ConfirmPassword"]
${FIRST_PAGE_REGISTER_DRIVER_TERMS_OF_USE_CHECKBOX}                //input[@type="checkbox"][following-sibling::*[contains(text(), 'I agree with')]]
${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}                          [class="x-btn x-btn-primary"]

# *** Second page ***
# Lokátory pro select elementy - používáme label-based selektory
${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}                   xpath=//label[contains(text(), "Native language")]/..//select
${SECOND_PAGE_REGISTER_DRIVER_LEVEL_OF_ENGLISH_DROPDOWN}           xpath=//label[contains(text(), "Level")]/..//select
${SECOND_PAGE_REGISTER_DRIVER_ADD_NEW_LANGUAGE_BUTTON}             [class="x-btn x-btn-secondary"]
${SECOND_PAGE_REGISTER_DRIVER_ANOTHER_LANGUAGE_DROPDOWN}           //*[contains(text(), "Additional language")]/..//select
${SECOND_PAGE_REGISTER_DRIVER_DRIVING_EXPERIENCE_DROPDOWN}         xpath=//label[contains(text(), "Years of Driving Experience")]/..//select
${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}                      [name="Model.AboutMe"]
${SECOND_PAGE_REGISTER_DRIVER_NEXT_BUTTON}                         css=button.x-btn-primary:has-text("Next")

# *** Third page ***
${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}                     [name="Model.CountryId"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}                [name="Model.IdentificationNumber"]
${THIRD_PAGE_REGISTER_DRIVER_VAT_PAYER_CHECKBOX}                   css=label.form-check-label:has-text("I am the VAT Payer")
${THIRD_PAGE_REGISTER_DRIVER_VAT_NUMBER_INPUT}                     [name="Model.VatNumber"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NAME_INPUT}                  [name="Model.BusinessName"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_ADDRESS_INPUT}               [name="Model.BusinessStreet"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_CITY_INPUT}                  [name="Model.BusinessCity"]
${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}                       [name="Model.BusinessZipCode"]
${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}                           [name="Model.IbanInEuro"]
${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}                            [name="Model.Bic"]
${THIRD_PAGE_REGISTER_DRIVER_FINISH_BUTTON}                        [class="x-btn x-btn-primary"]

# *** Finish page ***
${REGISTER_FINISH_PAGE_EMAIL_TEXTAREA}                             [class="notification-component alert alert-dismissible fade show alert-primary notification-component-visible"]
${REGISTER_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}                      Verification email was sent, check your email.
