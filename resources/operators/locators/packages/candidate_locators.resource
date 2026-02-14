*** Variables ***

${PACKAGES_CANDIDATE_EDIT_BUTTON}                  [class="x-btn x-btn-secondary x-btn-sm mi-btn-icon mi-edit"]
# *** Orders Tab ***
${PACKAGES_CANDIDATE_ORDERS_TAB_BUTTON}            css=.x-btn.x-btn-light.x-btn-sm.mi-btn.mi-map-pin
${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_BUTTON}        css=.x-btn.x-btn-primary.x-btn-sm:has-text("Add journey by order # ")
${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_INPUT}         [data-testid="journey-by-order-id"]
${PACKAGES_CANDIDATE_SEARCH_JOURNEY_ID_BUTTON}     [data-testid="btn-search-journey-by-order-id"]
${PACKAGES_CANDIDATE_ADD_JOURNEY_BUTTON}           [data-testid="btn-add-journey-by-order-id"]
# *** Detail Tab ***
${PACKAGES_CANDIDATE_DETAIL_TAB_BUTTON}            css=.x-btn.x-btn-light.x-btn-sm.mi-btn.mi-file >> text=Detail
${PACKAGES_CANDIDATE_CREATE_PACKAGE_BUTTON}        "Create package"
${PACKAGES_CANDIDATE_DETAIL_EDIT_BUTTON}           css=.x-btn.x-btn-primary.x-btn-sm >> text=Edit
${PACKAGES_CANDIDATE_NAME_INPUT}                   [name="Description.Name"]
${PACKAGES_CANDIDATE_NOTE_FOR_OPERATOR}            [name="Description.NoteForOperator"]
${PACKAGES_CANDIDATE_NOTE_FOR_DRIVER}              [name="Description.NoteForDriver"]
${PACKAGES_CANDIDATE_SAVE}                         css=.x-btn.x-btn-primary.x-btn-sm >> text=Save
# *** Modal ***
${PACKAGES_CANDIDATE_ACCEPT_MODAL}                 [data-testid="pop-up-modal-accept"]