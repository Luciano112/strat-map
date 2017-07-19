$(document).on "turbolinks:load", ->
  
  return unless $(".strat_columns.edit").length == 1 or $(".strat_columns.new").length == 1
  
  console.log "form js loading?"
  # var cloneIndex = $(".layer-fields_0").length;
  layerNum = $('.layer').length
  indexNum = (layerNum) + (-1)
  removeBtn = '<span class = \'btn btn-xs btn-default remove_btn\'><i class=\'glyphicon glyphicon-minus\'></i> Remove section </span>'
  # collapseAnchor = '<a data-toggle="collapse" href="#form-collapse' + indexNum + '"> <b>Stratum #' + indexNum+1 +'</b> </a>'
  #to check for current number of fields. 
  #Critical for edit form.

  clone = ->
    # https://stackoverflow.com/questions/10308621/jquery-change-clone-inputs-to-empty
    # Here we actually modify the cloned object and not the current object!
    source = $('.layer-fields_0')
    cloned = source.clone()
    cloned.find('input,textarea,select').val ''
    # Clears values
    cloned.val('').appendTo('#layer-container').attr('class', 'panel panel-default xtra-layer layer-fields_' + layerNum).attr('data-index', layerNum).find('*').each ->
      fieldName = $(this).attr('data-fieldname')
      idOrLabel = 'strat_column_layers_attributes_' + layerNum + '_' + fieldName
      name = 'strat_column[layers_attributes][' + layerNum + ']' + '[' + fieldName + ']'
      # For label fields
      $(this).find('label').attr for: idOrLabel
      # For select fields
      $(this).find('select').attr
        id: idOrLabel
        name: name
      # For input fields
      $(this).find('input').attr
        id: idOrLabel
        name: name
      # For textarea
      $(this).find('textarea').attr
        id: idOrLabel
        name: name
      headerName = 'section-label_' + layerNum
      # if the object has a section-label class...
      if $(this).attr('class') == 'section-label section-label_0'
        # For Section header
        $(this).text ''
        # change the object's class to section-label_index
        $(this).attr 'class', headerName
        # Append collapse anchor
        collapseAnchor = '<a data-toggle="collapse" href="#form-collapse' + (layerNum) + '"> <b>Stratum #' + (layerNum+1) + '</b> </a>'
        $(this).append collapseAnchor
        
        # Add data attribute to remove btn
        removeBtn = '<span class = \'btn btn-xs btn-default remove_btn\' data-removeindex=' + layerNum + '><i class=\'glyphicon glyphicon-minus\'></i> Remove section </span>'
        # Select that section-label_index and append html
        $(this).append removeBtn
        
      collapseId = 'form-collapse' + layerNum   
      if $(this).attr('id') == 'form-collapse0'
        $(this).attr 'id', collapseId
        
      # Remove tooltip...
      if $(this).hasClass('tooltips')
        $(this).remove()
        
      return
    layerNum++
    return

  if layerNum > 1
    lastChildren = $('.layer').slice(-layerNum + 1)
    lastChildren.each ->
      `var removeBtn`
      dataIndex = $(this).attr('data-index')
      removeBtn = '<span class = \'btn btn-xs btn-default remove_btn\' data-removeindex=' + dataIndex + '><i class=\'glyphicon glyphicon-minus\'></i> Remove section </span>'
      $(this).find('.section-label').append removeBtn
      return
    # cloneIndex = layerNum;
  $('.add_btn').on 'click', clone
  # NOTE: Event handlers are bound only to the currently selected elements; 
  # they must exist at the time your code makes the call to .on()
  # http://api.jquery.com/on/
  $('#layer-container').on 'click', '.remove_btn', ->
    dataIndexRemove = $(this).attr('data-removeindex')
    # var toSearch = data-index=
    $('html').find('[data-index="' + dataIndexRemove + '"]').find('.checkbox > input.delete_member').val('true').appendTo '#layer-container'
    $('html').find('[data-index="' + dataIndexRemove + '"]').remove()
    return
  return

# ---
# generated by js2coffee 2.2.0