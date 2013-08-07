class InventoryCheckResult < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :status_1, :status_2, :status_3, :status_4, :status_5, :status_6, :status_7, :status_8, :status_9, :item_identifier, :original_title, :shelf_group_names, :inventory_check_datum_id

  belongs_to :inventory_manage
  belongs_to :inventory_check_datum

  default_scope order('item_identifier')

  def display_status_name
    statuses = []
    columns = [
      [:status_1, 'activerecord.attributes.inventory_check_result.status_1'],
      [:status_2, 'activerecord.attributes.inventory_check_result.status_2'],
      [:status_3, 'activerecord.attributes.inventory_check_result.status_3'],
      [:status_4, 'activerecord.attributes.inventory_check_result.status_4'],
      [:status_5, 'activerecord.attributes.inventory_check_result.status_5'],
      [:status_6, 'activerecord.attributes.inventory_check_result.status_6'],
      [:status_7, 'activerecord.attributes.inventory_check_result.status_7'],
      [:status_8, 'activerecord.attributes.inventory_check_result.status_8'],
      [:status_9, 'activerecord.attributes.inventory_check_result.status_9'],
      [:skip_flag, 'activerecord.attributes.inventory_check_result.skip_flag'],
    ]

    columns.each do |column|
      if self.__send__(column[0]) != 0
        statuses << I18n.t(column[1])
      end
    end
    return statuses.join(' ')
  end

  def self.has_error?(manage_id)
    @inventory_check_results = InventoryCheckResult.joins('left outer join inventory_check_data_skips on inventory_check_results.item_identifier = inventory_check_data_skips.item_identifier and inventory_check_results.inventory_manage_id = inventory_check_data_skips.inventory_manage_id').where(:inventory_manage_id => manage_id).where('inventory_check_data_skips.id is null')
    error_count = @inventory_check_results.where("status_1 = 1 or status_5 = 1 or status_6 = 1 or status_7 = 1 or status_9 = 1").count
    return (error_count > 0)?(true):(false)
  end

  def self.get_result_list_tsv(results, options)
    data = String.new
    data << "\xEF\xBB\xBF".force_encoding("UTF-8") + "\n"

    item_identifier_label = I18n.t('inventory_page.condition_none')
    status_label = I18n.t('inventory_page.condition_none')

    if options[:item_identifier]
      item_identifier_label = options[:item_identifier]
    end
    if options[:status_types]
      a = []
      status_keys = options[:status_types].keys
      status_keys.each do |key|
        a << I18n.t("activerecord.attributes.inventory_check_result.status_#{key}")
      end
      status_label = a.join(',')
    end

    # manifestation_checkout_stat
    data << '"' + I18n.t('activerecord.models.inventory_check_result') + "\"\n"
    data << '"' + I18n.t('inventory_page.output_condition') + "\"\n"
    data << '"' + I18n.t('activerecord.attributes.inventory_check_result.item_identifier') + ":" + item_identifier_label + "\"\n"
    data << '"' + I18n.t('activerecord.attributes.inventory_check_result.status') + ":" + status_label + "\"\n"

    data << "\n"

    columns = [
      [:item_identifier, 'activerecord.attributes.inventory_check_result.item_identifier'],
      [:shelf_group_names, 'activerecord.attributes.inventory_check_result.shelf_group_names'],
      [:original_title, 'activerecord.attributes.inventory_check_result.original_title'],
      [:status_1, 'activerecord.attributes.inventory_check_result.status_1'],
      [:status_2, 'activerecord.attributes.inventory_check_result.status_2'],
      [:status_3, 'activerecord.attributes.inventory_check_result.status_3'],
      [:status_4, 'activerecord.attributes.inventory_check_result.status_4'],
      [:status_5, 'activerecord.attributes.inventory_check_result.status_5'],
      [:status_6, 'activerecord.attributes.inventory_check_result.status_6'],
      [:status_7, 'activerecord.attributes.inventory_check_result.status_7'],
      [:status_8, 'activerecord.attributes.inventory_check_result.status_8'],
      [:status_9, 'activerecord.attributes.inventory_check_result.status_9'],
      [:skip_flag, 'activerecord.attributes.inventory_check_result.skip_flag'],
    ]
    # title column
    row = columns.map {|column| I18n.t(column[1])}
    data << '"'+row.join("\"\t\"")+"\"\n"

    results.each do |r|
      row = []
      columns.each do |column|
        case column[0]
        when :original_title
          manifestation = r.original_title
          #nmanifestation = stat.manifestation.original_title if stat.manifestation
          row << manifestation
        when :item_identifier, :shelf_group_names, :status_1, :status_2, :status_3, :status_4, :status_5,
              :status_6, :status_7, :status_8, :status_9, :skip_flag
          row << r.__send__(column[0])
        end
      end
      data << '"' + row.join("\"\t\"") + "\"\n"
    end
    return data
  end
end
