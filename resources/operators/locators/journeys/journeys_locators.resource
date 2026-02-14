*** Variables ***
### *** Modal ***
${JOURNEY_MODAL_ACCEPT_BUTTON}                                [data-testid="pop-up-modal-accept"] >> nth=0
${JOURNEY_MODAL_REJECT_BUTTON}                                [data-testid="pop-up-modal-reject"]
${JOURNEY_HINT_BUTTON}                                        [data-testid="journey-driver-cash-note-popup-0"]
${JOURNEY_MODAL_OK_BUTTON}                                    [data-testid="pop-up-modal-ok"]

### *** New Request ***
${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}                         [class="x-btn x-btn-primary x-btn-sm mi-btn-icon mi-file"]
${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}                          [data-testid="journey-close-panel-0"]
${JOURNEYS_CANCEL_BUTTON}                                     [data-testid="btn-journey-status-cancel"]
${JOURNEYS_EDIT_ALL_BUTTON}                                   [data-testid="btn-journey-edit-all"]
### *** Form - Create New Request levá strana formu ***
${JOURNEYS_FORM_REQUEST_SHOW_WITHOUT_REQUEST_BUTTON}          [data-testid="btn-journey-status-show-without-request"]
${JOURNEYS_FORM_REQUEST_NEW_BOOKING_BUTTON}                   [data-testid="btn-journey-status-new-booking"]
${JOURNEYS_FORM_REQUEST_WM_SENT_BUTTON}                       [data-testid="btn-journey-status-welcome-message-sent"]
${JOURNEYS_FORM_REQUEST_TYPE_DROPDOWN}                        [name="JourneyBehavior.JourneyTypeId"]
${JOURNEYS_FORM_REQUEST_TYPE_TEXTAREA}                        xpath=//div[contains(@class,"font-strong-label") and text()="Type"]/following-sibling::div[contains(@class,"font-mid-label")][1]
@{JOURNEYS_FORM_REQUEST_TYPE_LIST}                            [data-testid="journey-status-journey-type-Transfer"]     
...                                                           [data-testid="journey-status-journey-type-Day trip"]
${JOURNEYS_FORM_REQUEST_DATE_PICKER}                          [####]
${JOURNEYS_FORM_DATE_PICKER_TEXTAREA}                         xpath=//div[text()="Date"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_PICKUP_INPUT}                         input[placeholder="Pick-up time"]:visible
${JOURNEYS_FORM_REQUEST_TIME_TEXTAREA}                        xpath=//div[contains(@class,"font-strong-label") and contains(.,"Expected drop-off time")]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_REQUEST_PICK_UP_TIME_TEXTAREA}                xpath=//div[contains(@class,"font-strong-label") and contains(.,"Pick-up time")]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}                     [data-testid="journey-definition-form-passengers-count"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_COUNT_TEXTAREA}            xpath=//div[text()="Passengers count"]/following-sibling::div[contains(@class,"text-break")][1] 
${JOURNEYS_FORM_REQUEST_CAR_TYPE_DROPDOWN}                    [data-testid="journey-definition-form-car-type"]
${JOURNEYS_FORM_REQUEST_CAR_TYPE_TEXTAREA}                    xpath=//div[text()="Car type"]/following-sibling::div[contains(@class,"text-break")][1]
@{JOURNEYS_FORM_REQUEST_CAR_TYPE_LIST}                        Sedan
...                                                           MPV
...                                                           Van
...                                                           PremiumSedan
...                                                           PremiumVan
...                                                           BigVan
...                                                           Bus
${JOURNEYS_FORM_REQUEST_OPERATOR_NOTE_INPUT}                  [data-testid="journey-definition-form-note-for-operator"]
${JOURNEYS_FORM_REQUEST_OPERATOR_NOTE_TEXTAREA}               xpath=//div[text()="Note for operator"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_ISSUE_CHECKBOX}                       [data-testid="journey-definition-form-issue"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_WHATSAPP_TEXTAREA}         css=.fst-italic
${JOURNEYS_FORM_REQUEST_PASSENGERS_WHATSAPP_CHECKBOX}         [data-testid="journey-passengers-contact-whats-app-supported"]
${JOURNEYS_FORM_REQUEST_DRIVER_NOTE_INPUT}                    [data-testid="journey-definition-form-note-for-driver"]
${JOURNEYS_FORM_REQUEST_NOTE_FOR_DRIVER_TEXTAREA}             xpath=//div[text()="Note for driver"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_PASSENGERS_FIRST_NAME_INPUT}          [data-testid="journey-passengers-contact-first-name"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_FIRST_NAME_TEXTAREA}       xpath=//div[text()="First name"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_PASSENGERS_LAST_NAME_INPUT}           [data-testid="journey-passengers-contact-last-name"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_LAST_NAME_TEXTAREA}        xpath=//div[text()="Last name"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_INPUT}               [data-testid="journey-passengers-contact-phone"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_TEXTAREA}            xpath=//div[text()="Phone"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_INPUT}               [data-testid="journey-passengers-contact-email"]
${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_TEXTAREA}            xpath=//div[text()="Email"]/following-sibling::div[contains(@class,"text-break")][1]
${JOURNEYS_FORM_REQUEST_SAVE_ALL_BUTTON}                      [data-testid="btn-journey-save-all"]
${JOURNEYS_FORM_REQUEST_CANCEL_ALL_BUTTON}                    [data-testid="btn-journey-cancel-all"]
                                                              
### *** Form - Create New Request pravá strana formu ***

## *** Product order - edit *** 
${JOURNEY_FORM_REQUEST_PRODUCT_EDIT_BUTTON}                    [data-testid="btn-journey-product-detail-edit"]
${JOURNEY_FORM_REQUEST_PRODUCT_NOTE_INPUT}                     [name="OrderDetail.ProductNote"]
${JOURNEY_FORM_REQUEST_PRODUCT_SAVE_BUTTON}                    [data-testid="btn-journey-product-detail-save"]
${JOURNEY_FORM_REQUEST_PRODUCT_CANCEL_BUTTON}                  [data-testid="btn-journey-product-detail-cancel"]
${JOURNEY_FORM_REQUEST_PRODUCT_ID_TEXTAREA}                    [data-testid="journey-detail-order-id"]
${JOURNEY_FORM_REQUEST_CREATE_PACKAGE_CANDIDATE_BUTTON}        [data-testid="btn-journey-status-create-package-candidate"]
## *** Accounting order - edit ***
${JOURNEY_FORM_REQUEST_ACCOUTNING_EDIT_BUTTON}                 [data-testid="btn-journey-accounting-edit"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_NOTE_INPUT}                  [data-testid="accounting-cash-note"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_SAVE_BUTTON}                 [data-testid="btn-accounting-save"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_CANCEL_BUTTON}               [data-testid="btn-accounting-cancel"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_SIMILLIAR_BUTTON}            [data-testid="btn-journey-accounting-show-similar-journeys"]
# *** Bokun ***
${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_BUTTON}                [data-testid="btn-accounting-add-payment-source-Bokun"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_AMOUNT_INPUT}          [data-testid="accounting-amount-Bokun"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_PROFIT_INPUT}          [data-testid="accounting-driver-profit-Bokun"] 
${JOURNEYS_FORM_ACCOUNTING_BOKUN_AMOUNT_TEXTAREA}              xpath=//div[text()="Bokun"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_ACCOUNTING_BOKUN_PROFIT_TEXTAREA}              xpath=//div[text()="Price for driver €"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_ACCOUNTING_REST_OF_DRIVER_PAYMENT_TEXTAREA}    xpath=//div[text()="Rest of driver payment €"]/following-sibling::div[contains(@class,"font-mid-label")][1]
# *** Driver cash ***
${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_EDIT_BUTTON}          [data-testid="btn-accounting-add-payment-source-Driver cash"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_AMOUNT_INPUT}         [data-testid="accounting-amount-DriverCash"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_PROFIT_INPUT}         [data-testid="accounting-driver-profit-DriverCash"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_COLLECTING_INPUT}     [data-testid="accounting-cash-collection-note"]
${JOURNEYS_FORM_ACCOUNTING_DRIVER_CASH_AMOUNT_TEXTAREA}        xpath=//div[text()="Driver cash"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_ACCOUNTING_DRIVER_CASH_COLLECTING_TEXTAREA}    xpath=//div[text()="Cash collecting"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${JOURNEYS_FORM_ACCOUNTING_DRIVER_REST_OF_PAYMENT_TEXTAREA}    xpath=//div[text()="Rest of driver payment €"]/following-sibling::div[contains(@class,"font-mid-label")][1]
# *** MEJ Stripe ***
${JOURNEY_FORM_REQUEST_ACCOUTNING_STRIPE_EDIT_BUTTON}          [data-testid="btn-accounting-add-payment-source-MEJ Stripe"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_STRIPE_AMOUNT_INPUT}         [data-testid="accounting-amount-MejStripe"]
${JOURNEY_FORM_REQUEST_ACCOUTNING_STRIPE_PROFIT_INPUT}         [data-testid="accounting-driver-profit-MejStripe"]
${JOURNEYS_FORM_ACCOUNTING_MEJ_STRIPE_AMOUNT_TEXTAREA}         xpath=//div[text()="MEJ Stripe"]/following-sibling::div[contains(@class,"font-mid-label")][1]


## *** Location ***

${JOURNEY_FORM_REQUEST_LOCATION_EDIT_BUTTON}                   [data-testid="btn-journey-route-edit"]
${JOURNEY_FORM_REQUEST_LOCATION_SAVE_BUTTON}                   [data-testid="btn-journey-route-save"]
${JOURNEY_FORM_REQUEST_LOCATION_CANCEL_BUTTON}                 [data-testid="btn-journey-route-cancel"]
${JOURNEY_FORM_REQUEST_PICK_UP_INPUT}                          [placeholder="Search location"]
${JOURNEY_FORM_REQUEST_PICKUP_TIME_TEXTAREA}                   xpath=//div[text()="Pick up"]/following-sibling::div[@class="inflex-row-left-top x-gap-2"][2]/div[@class="c-journey-route-width"]
${JOURNEY_FORM_REQUEST_DROP_OFF_TIME_TEXTAREA}                 xpath=//div[text()="Drop off"]/following-sibling::div[@class="inflex-row-left-top x-gap-2"][2]/div[@class="c-journey-route-width"]
${JOURNEY_FORM_REQUEST_DROP_OFF_INPUT}                         [placeholder="Search city"]
${JOURNEY_FORM_REQUEST_PICK_UP_LIST}                           css=.ddl-item >> nth=0
${JOURNEY_FORM_REQUEST_DROPP_OFF_LIST}                         css=.ddl-item >> nth=0
${JOURNEY_FORM_REQUEST_CHANGE_PICK_UP_ADRESS_BUTTON}           css=.x-btn.x-btn-dark.x-btn-sm.mi-btn-icon.mi-map-pin >> nth=0
${JOURNEY_FORM_REQUEST_ADD_STOPS_BUTTON}                       [data-testid="btn-add-route-stop"]
${JOURNEY_FORM_REQUEST_STOP_ADRESS_INPUT}                      [data-testid="select-location-1"] input
${JOURNEY_FORM_REQUEST_STOP_ADRESS_DURATION_INPUT}             [data-testid="stop-duration-1"]
${JOURNEY_FORM_REQUEST_STOP_ADRESS_TEXTAREA}                   css=.font-mid-label.c-journey-route-width >> nth=0
${JOURNEY_FORM_REQUEST_STOP_ADRESS_DURATION_TEXTAREA}          css=.font-mid-label.c-journey-route-width >> nth=1
${JOURNEY_FORM_REQUEST_STOP_ADRESS_LIST}                       css=.ddl-item >> nth=0