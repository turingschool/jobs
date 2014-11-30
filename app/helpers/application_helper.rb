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

  def markdown_renderer
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  def markdown(content)
    if content
      markdown_renderer.render(content).html_safe
    end
  end
end
