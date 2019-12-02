// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap-table/dist/bootstrap-table.min
//= require rails.validations
//= require rails.validations.simple_form
//= require modal_clientside_validation
//= require data-confirm-modal
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all
//= require_tree .

function saveLatestTab() {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    // save the latest tab
    localStorage.setItem('lastTab', $(this).attr('href'));
  });

  // go to the latest tab, if it exists
  var lastTab = localStorage.getItem('lastTab');
  if (lastTab) {
    $('[href="' + lastTab + '"]').tab('show');
  }
}

function showModalFlashSuccess(message) {
  $('#modalFlashSuccess').show();
  $('#modalFlashSuccess').html(message);
  setTimeout(function(){ $('#modalFlashSuccess').hide(); }, 5000);
}

function showModalFlashError(message, controller_name) {
  $('#modalFlashError-' + controller_name).show();
  $('#modalFlashError-'+ controller_name).html(message);
  setTimeout(function(){ $('#modalFlashError-'+ controller_name).hide(); }, 5000);
}

function showFlashError(message) {
  $('#flashError').show();
  $('#flashError').html(message);
  setTimeout(function(){ $('#flashError').hide(); }, 5000);
}

function alertTimeOut() {
  setTimeout(function(){ $('.alert').hide(); }, 5000);
}

function loadDataCalendars(url) {
  $('#calendars').fullCalendar({
    header: {
      left: 'prev today, next',
      center: 'title',
      right: 'month, listMonth'
    },
    theme: true,
    themeSystem:'bootstrap4',
    eventRender: function(eventObj, el) {
      el.popover({
        title: eventObj.title,
        content: 'จำนวนวันลา : '+ eventObj.total_date +' วัน เหตุผล : ' + eventObj.description,
        trigger: 'hover',
        placement: 'top',
        container: 'body'
      });
    },
    events: function(start, end, timezone, callback) {
      $.ajax({
        url: url,
        dataType: 'json',
        data: {
          start: start.format(),
          end: end.format()
        },
        success: function(datas) {
          callback(datas);
        }
      });
    }
  });
}

function reloadCalendars() {
  $('#calendars').fullCalendar('refetchEvents');
}

function halfDay(value) {
  if (value == 'Half-day leave') {
    $('.end-date').addClass('d-none')
    $('.half-day').removeClass('d-none')
    $('#vacation_half_day').attr('disabled', false);
  } else {
    $('.end-date').removeClass('d-none')
    $('.half-day').addClass('d-none')
    $('#vacation_half_day').attr('disabled', true);
  }
}

function addMoreSubject() {
  var formId = '#createOrUpdateTeacherModal';
  var lastSubject = $(formId + ' .tbody-subject').last();
  var lastSubjectId = lastSubject.attr('id');
  var lastIndex = parseInt(lastSubjectId.replace('tbodySubject', ''));

  var newIndex = lastIndex + 1;
  $(lastSubject).append(formSubject(newIndex));
}

function formSubject(index) {
  form_subject = '<tr id="trSubject'+ index +'">'+
                    '<td><div class="input string optional teacher_subjects_subject_code"><input class="string optional form-control" type="text" name="teacher[subjects_attributes]['+ index +'][subject_code]" id="teacher_subjects_attributes_'+ index +'_subject_code"></div></td>'+
                    '<td><div class="input string optional teacher_subjects_name"><input class="string optional form-control" type="text" name="teacher[subjects_attributes]['+ index +'][name]" id="teacher_subjects_attributes_'+ index +'_name"></div></td>'+
                    '<td><div class="input integer optional teacher_subjects_credit"><input class="numeric integer optional form-control" type="number" step="1" name="teacher[subjects_attributes]['+ index +'][credit]" id="teacher_subjects_attributes_'+ index +'_credit"></div></td>'+
                    '<td>'+
                      '<button type="button" class="btn btn-remove" onclick="removeSubject('+ index +')"><i class="far fa-trash-alt"></i></button>'+
                    '</td>'+
                  '</tr>'

  return form_subject
}

function removeSubject(index) {
  $('#trSubject' + index).remove();
}

