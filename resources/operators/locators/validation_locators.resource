*** Variables ***
# Blazorise validation CSS classes
${VALIDATION_INVALID_CLASS}           is-invalid
${VALIDATION_FEEDBACK_CLASS}          invalid-feedback
${VALIDATION_SUCCESS_CLASS}           valid-feedback

# Journey form - Passengers Count validation
${PASSENGERS_COUNT_VALIDATION}        css=[data-testid="journey-definition-form-passengers-count"] ~ .invalid-feedback

# Journey form - Notes validation
${NOTE_DRIVER_VALIDATION}             css=[data-testid="journey-definition-form-note-for-driver"] ~ .invalid-feedback
${NOTE_OPERATOR_VALIDATION}           css=[data-testid="journey-definition-form-note-for-operator"] ~ .invalid-feedback

# Journey form - Passenger Contact validation
${FIRST_NAME_VALIDATION}              css=[data-testid="journey-passengers-contact-first-name"] ~ .invalid-feedback
${LAST_NAME_VALIDATION}               css=[data-testid="journey-passengers-contact-last-name"] ~ .invalid-feedback
${PHONE_VALIDATION}                   css=[data-testid="journey-passengers-contact-phone"] ~ .invalid-feedback
${EMAIL_VALIDATION}                   css=[data-testid="journey-passengers-contact-email"] ~ .invalid-feedback

# Alternative: Check for invalid state on input itself
${PASSENGERS_COUNT_INVALID_STATE}     css=[data-testid="journey-definition-form-passengers-count"].is-invalid
${NOTE_DRIVER_INVALID_STATE}          css=[data-testid="journey-definition-form-note-for-driver"].is-invalid
${NOTE_OPERATOR_INVALID_STATE}        css=[data-testid="journey-definition-form-note-for-operator"].is-invalid
${FIRST_NAME_INVALID_STATE}           css=[data-testid="journey-passengers-contact-first-name"].is-invalid
${LAST_NAME_INVALID_STATE}            css=[data-testid="journey-passengers-contact-last-name"].is-invalid
${PHONE_INVALID_STATE}                css=[data-testid="journey-passengers-contact-phone"].is-invalid
${EMAIL_INVALID_STATE}                css=[data-testid="journey-passengers-contact-email"].is-invalid
