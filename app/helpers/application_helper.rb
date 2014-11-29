module ApplicationHelper

  def label_for(kind)
    {
      'feedback' => 'label-default',
      'code_challenge' => 'label-info',
      'phone_screen' => 'label-info',
      'culture_interview' => 'label-info',
      'technical_interview' => 'label-info',
      'contracting' => 'label-success'
    }[kind]
  end
end
