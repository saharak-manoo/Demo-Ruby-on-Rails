function registerFormValidate() {
  var result = true;
  if (!validateEmailUniqueness()) result = false;
  if (!validateAttachments()) result = false;
  setTimeout( function() {
    $('#registerSubmit').prop( "disabled", result );
  }, 100);
  return result;
}

function validateEmailUniqueness() {
  var status = 0;
  $(".form-group.email .invalid-feedback").remove();
  $.ajax({
    url: 'users/check_uniqueness?email=' + $('#user_email').val(),
    async: false,
    statusCode: {
      200: function() {
        // remove error message
        $('#user_email').removeClass('is-invalid');
        status = 200;
      },
      226: function() {
        setTimeout( function() {
          $('#user_email').addClass('is-invalid');
          $(".form-group.email").append('<div class="invalid-feedback">has already been taken</div>');
        }, 50);
        status = 226;
      },
      500: function() {
        status = 500;
      }
    }
  });

  do {
    //waiting for result
  } while (status == 0);

  return status == 200;
}

function validateAttachments() {
  var i = 0
  var fileInput = $('#user_attachments_attributes_0_file')
  var hasAttachment = false;
  do {
    if(fileInput.val() != '') {
      hasAttachment = true;
    }

    // next file input
    i++;
    fileInput = $('#user_attachments_attributes_' + i + '_file')
  } while (fileInput.length > 0)

  $(".user_attachments_file:first .invalid-feedback").remove();
  if (!hasAttachment) {
    setTimeout( function() {
      $('#user_attachments_attributes_0_file').addClass('is-invalid');
      $(".user_attachments_file:first").append('<div class="invalid-feedback" style="display:block;">can\'t be blank</div>');
    }, 50);
  } else {
    $('#user_attachments_attributes_0_file').removeClass('is-invalid');
  }

  return hasAttachment;
}
