*** Variables ***
### *** invoices Page Locators *** 
${ADMIN_INVOICES_CREATE_NEW_BUTTON}                         [class="x-btn x-btn-primary x-btn-sm mi-btn-icon mi-file"]
${ADMIN_INVOICES_FORM_PROFIT_FOR_MEJ_INPUT}                 [name="item.ProfitForMej"]
${ADMIN_INVOICES_FORM_ORDER_NAME_INPUT}                    [name="Invoice.OrderId"]




### *** Filter Panel ***
${ADMIN_INVOICES_FILTER_PANEL}                              css=.c-invoice-filter-pannel
${ADMIN_INVOICES_FILTER_DATE_DROPDOWN}                      css=.c-invoice-filter-pannel .form-input-select >> nth=0
${ADMIN_INVOICES_FILTER_VIES_STATE_DROPDOWN}                css=.c-invoice-filter-pannel .c-multi-select-component
${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}                   css=.c-invoice-filter-pannel input[placeholder*="Vat number"]
${ADMIN_INVOICES_FILTER_SHOW_DUPLICITIES_CHECKBOX}          css=.c-invoice-filter-pannel input[type="checkbox"]
${ADMIN_INVOICES_FILTER_SEARCH_BUTTON}                      css=.c-invoice-filter-pannel .mi-btn-icon.mi-search
${ADMIN_INVOICES_FILTER_RESET_BUTTON}                       css=.c-invoice-filter-pannel .mi-btn-icon.mi-close-1
${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}                css=.c-invoice-filter-pannel .x-btn.x-btn-dark.x-btn-sm >> nth=0
${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}                css=.c-invoice-filter-pannel .x-btn.x-btn-dark.x-btn-sm >> nth=1
${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}                css=.c-invoice-filter-pannel .x-btn.x-btn-dark.x-btn-sm >> nth=2

### *** Filter Summary ***
${ADMIN_INVOICES_FILTER_MANUALLY_CREATED_TEXTAREA}          css=.c-invoice-filter-pannel strong:has-text("Manually created") + text
${ADMIN_INVOICES_FILTER_CREATED_FROM_ORDERS_TEXTAREA}       css=.c-invoice-filter-pannel strong:has-text("Created from orders") + text
${ADMIN_INVOICES_FILTER_TOTAL_TEXTAREA}                     css=.c-invoice-filter-pannel strong:has-text("Total") + text

### *** Table ***
${ADMIN_INVOICES_TABLE}                                     css=.main-table
${ADMIN_INVOICES_TABLE_ROW}                                 css=.main-table tbody tr
${ADMIN_INVOICES_NEW_BUTTON}                                css=.x-btn.x-btn-primary.x-btn-sm.mi-btn-icon.mi-file

### *** Form - Invoice Detail ***
${ADMIN_INVOICES_FORM_ORDER_INPUT}                          css=input[placeholder="Order #"]
${ADMIN_INVOICES_FORM_DATE_PICKER}                          css=.date-picker-container input

### *** Form - Invoice Items ***
${ADMIN_INVOICES_FORM_PRODUCT_NAME_INPUT}                   css=input[placeholder="Product name"]
${ADMIN_INVOICES_FORM_PROFIT_MEJ_INPUT}                     css=input[placeholder="Profit for MEJ"]
${ADMIN_INVOICES_FORM_RECEIVED_PAYMENT_INPUT}               css=input[placeholder="Received payment"]
${ADMIN_INVOICES_FORM_NO_ITEMS_ERROR_TEXTAREA}              css=.error-validation-message

### *** Form - Driver Selection ***


### *** Form - Driver Detail ***
${ADMIN_INVOICES_FORM_DRIVER_DROPDOWN}                      css=.form-input-select-small.stretch-width
${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}                    css=input[placeholder="Identification No"]
${ADMIN_INVOICES_FORM_VAT_NO_INPUT}                         css=input[placeholder="VAT No."]
${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}                  css=input[placeholder="Business name"]
${ADMIN_INVOICES_FORM_NAME_INPUT}                           css=input[placeholder="Name"]
${ADMIN_INVOICES_FORM_EMAIL_INPUT}                          css=input[placeholder="Email"]

### *** Form - Address ***
${ADMIN_INVOICES_FORM_STREET_INPUT}                         css=input[placeholder="Street"]
${ADMIN_INVOICES_FORM_CITY_INPUT}                           css=input[placeholder="City"]
${ADMIN_INVOICES_FORM_ZIP_INPUT}                            css=input[placeholder="Zip code"]
${ADMIN_INVOICES_FORM_COUNTRY_DROPDOWN}                     css=.form-input-select-small.c-invoice-width

### *** Form Buttons ***
${ADMIN_INVOICES_FORM_SAVE_BUTTON}                          css=.table-inner-panel-sw .x-btn.x-btn-primary.x-btn-sm:text("Save")
${ADMIN_INVOICES_FORM_CANCEL_BUTTON}                        css=.table-inner-panel-sw .x-btn.x-btn-secondary.x-btn-sm
${ADMIN_INVOICES_FORM_REMOVE_INVOICE_BUTTON}                css=.table-inner-panel-sw .x-btn.x-btn-danger.x-btn-sm:text("Remove")

### *** Validation Messages ***
${ADMIN_INVOICES_VALIDATION_ERROR_TEXTAREA}                 css=.invalid-feedback:visible
${ADMIN_INVOICES_FORM_ERROR_TEXTAREA}                       css=.error-validation-message

### *** Detail View - Read Only ***
${ADMIN_INVOICES_DETAIL_INVOICE_NO_TEXTAREA}                xpath=//div[text()="Invoice #"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_ORDER_NO_TEXTAREA}                  xpath=//div[text()="Order #"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_TYPE_TEXTAREA}                      xpath=//div[text()="Type"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_DATE_TEXTAREA}                      xpath=//div[text()="Date"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_DUE_DATE_TEXTAREA}                  xpath=//div[text()="Due date"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_TRIP_DATE_TEXTAREA}                 xpath=//div[text()="Trip date"]/following-sibling::div[contains(@class,"font-mid-label")][1]

### *** Detail View - Driver Info ***
${ADMIN_INVOICES_DETAIL_BUSINESS_NO_TEXTAREA}               xpath=//div[text()="Business No."]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_VAT_NO_TEXTAREA}                    xpath=//div[text()="VAT No."]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_BUSINESS_NAME_TEXTAREA}             xpath=//div[text()="Business name"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_NAME_TEXTAREA}                      xpath=//div[text()="Name"]/following-sibling::div[contains(@class,"font-mid-label")][1]
${ADMIN_INVOICES_DETAIL_EMAIL_TEXTAREA}                     xpath=//div[text()="Email"]/following-sibling::div[contains(@class,"font-mid-label")][1]

### *** Detail View Buttons ***
${ADMIN_INVOICES_DETAIL_EDIT_BUTTON}                        css=.table-inner-panel-sw .x-btn.x-btn-primary.x-btn-sm >> nth=0
${ADMIN_INVOICES_DETAIL_NEW_FOR_DRIVER_BUTTON}              css=.table-inner-panel-sw .x-btn.x-btn-secondary.x-btn-sm >> nth=0
${ADMIN_INVOICES_DETAIL_UPDATE_BUTTON}                      css=.table-inner-panel-sw .x-btn.x-btn-secondary.x-btn-sm >> nth=1
${ADMIN_INVOICES_DETAIL_PDF_BUTTON}                         css=.table-inner-panel-sw .x-btn.x-btn-dark.x-btn-sm >> nth=0
${ADMIN_INVOICES_DETAIL_POHODA_XML_BUTTON}                  css=.table-inner-panel-sw .x-btn.x-btn-dark.x-btn-sm >> nth=1
${ADMIN_INVOICES_DETAIL_REMOVE_BUTTON}                      css=.table-inner-panel-sw .x-btn.x-btn-danger.x-btn-sm

### *** Modal ***
${ADMIN_INVOICES_MODAL_ACCEPT_BUTTON}                       [data-testid="pop-up-modal-accept"]
${ADMIN_INVOICES_MODAL_REJECT_BUTTON}                       [data-testid="pop-up-modal-reject"]
${ADMIN_INVOICES_MODAL_OK_BUTTON}                           [data-testid="pop-up-modal-ok"]
