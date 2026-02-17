*** Variables ***
${PACKAGES_PACKAGES_TAB_BUTTON}                            css=.x-btn.x-btn-light.x-btn-sm.mi-btn.mi-cube
${PACKAGES_1ST_EDIT_BUTTON}                                [data-testid="package-open-panel-0"]
${PACKAGES_EDIT_BY_NAME}                                   xpath=(//td[text()='{}']/ancestor::tr//button[starts-with(@data-testid, 'package-open-panel-')])[1]
${PACKAGES_DRIVER_SELECTION_TAB_BUTTON}                    css=.x-btn.x-btn-light.x-btn-sm.mi-btn.mi-search

# *** Driver Selection Tab ***
${PACKAGES_DRIVER_SELECTION_SEARCH_BUTTON}                 [data-testid="btn-filter-carrier-selection"]
${PACKAGES_DRIVER_SELECTION_REQUEST_NOW_BUTTON}            [data-testid="carrier-selection-request-now-button"]
${PACKAGES_DRIVER_SELECTION_DRIVER_CHECKBOX}               xpath=//a[text()="Mr. Mpv"]/ancestor::tr/td[1]/div/input
${PACKAGES_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}      xpath=//a[text()="Shuttle Company"]/ancestor::tr/td[1]/div/input