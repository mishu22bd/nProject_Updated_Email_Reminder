module ImdashsHelper

	def issuesassignedtome_items
    Issue.visible.open.
     where(:assigned_to_id => ([User.current.id] + User.current.group_ids)).
      includes(:assigned_to, :tracker, :priority, :category, :fixed_version, :status, :project).
      order(sort_clause).
      all
  end

  def issuesreportedbyme_items
    
      Issue.visible.
      where(:author_id => User.current.id).
      includes(:assigned_to, :tracker, :priority, :category, :fixed_version, :status ,:project).
      order(sort_clause).
      all
  end
  
  def issueswatched_items
    Issue.visible.on_active_project.watched_by(User.current.id).recently_updated.all
  end
  def issues_only
     issues_all = issuesreportedbyme_items
     issues_all.push *issueswatched_items
     issues_all.push *issuesassignedtome_items
     all = issues_all.reject{|v| v.tracker_id == 4}
     rest = all.reject {|k| k.status_id == 5 }
     rest.inject([]) { |result,h| result << h unless result.include?(h); result }
  end
 
  def tasks_only
     tasks_all = issuesreportedbyme_items
     tasks_all.push *issueswatched_items
     tasks_all.push *issuesassignedtome_items
     all = tasks_all.reject{|v|v.tracker_id == 5}
     rest = all.reject {|k| k.status_id == 5 }
     rest.inject([]) { |result,h| result << h unless result.include?(h); result }
    
  end
 def render_descendants_tree(issue)
    s = '<form><table class="list issues">'
    issue_list(issue.descendants.visible.sort_by(&:lft)) do |child, level|
      css = "issue issue-#{child.id} hascontextmenu"
      css << " idnt idnt-#{level}" if level > 0
      s << content_tag('tr',
             content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
             content_tag('td', link_to_issue(child, :truncate => 60, :project => (issue.project_id != child.project_id)), :class => 'subject') +
             content_tag('td', h(child.status)) +
             content_tag('td', link_to_user(child.assigned_to)) +
             content_tag('td', progress_bar(child.done_ratio, :width => '80px')),
             :class => css)
    end
    s << '</table></form>'
    s.html_safe
  end

  def calendar_items(startdt, enddt)
    assign = Issue.visible.
      where(:project_id => User.current.projects.map(&:id), :assigned_to_id => ([User.current.id] + User.current.group_ids)).
      where("(start_date>=? and start_date<=?) or (due_date>=? and due_date<=?)", startdt, enddt, startdt, enddt).
      includes(:project, :tracker, :priority, :assigned_to).
      all

    author = Issue.visible.
      where(:project_id => User.current.projects.map(&:id), :author_id => User.current.id).
      where("(start_date>=? and start_date<=?) or (due_date>=? and due_date<=?)", startdt, enddt, startdt, enddt).
      includes(:project, :tracker, :priority, :assigned_to).
      all
    watched =  Issue.visible.on_active_project.watched_by(User.current.id).where("(start_date>=? and start_date<=?) or (due_date>=? and due_date<=?)", startdt, enddt, startdt, enddt)
     i = assign.push *author
     i.push *watched 
  end

  def burn(estimate, spent)
      if estimate != 0.0
      ((spent*100)/estimate).ceil
      else
      return 0
    end
  end

  # def project_list(project_id)
  #   projects =  Project.where(:id => project_id)
  #     projects.each do |project| 
  #       return project
  #     end
  # end
end
