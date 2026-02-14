*** Variables ***

${ADMIN_TOUR_ROUTES_EDIT_BUTTON}                    [class="x-btn x-btn-secondary x-btn-sm mi-btn-icon mi-edit"]
${ADMIN_TOUR_ROUTES_SEARCH_BUTTON}                  [class="x-btn x-btn-primary x-btn-sm mi-btn-icon mi-search"]
${ADMIN_TOUR_ROUTES_STATE_DROPDOWN}                 css=.form-select.form-input-select.small-input.c-journey-filter-component.c-multi-select-component

# *** Accounting sekce ***
${ADMIN_TOUR_ROUTES_ACCOUNTING_EDIT_BUTTON}         css=.table-inner-panel:has(.font-strong-dark:has-text("Accounting")) button:has-text("Edit")
${ADMIN_TOUR_ROUTES_ACCOUNTING_SAVE_BUTTON}         css=.x-btn.x-btn-primary >> text=Save
${ADMIN_TOUR_ROUTES_ACCOUNTING_APPROVE_BUTTON}      css=.x-btn.x-btn-success.x-btn-sm >> text=Approve
${ADMIN_TOUR_ROUTES_MODAL_ACCEPT_BUTTON}            [data-testid="pop-up-modal-accept"]
${ADMIN_TOUR_ROUTES_WA2_ID_TEXTAREA}                css=.font-strong-label.my-1:text-is("WA2 #") + .font-mid-label.text-break