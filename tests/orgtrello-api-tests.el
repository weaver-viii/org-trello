(require 'orgtrello-api)

(ert-deftest testing-orgtrello-api--get-boards ()
  (let ((h (orgtrello-api--get-boards)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/members/me/boards"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-board ()
  (let ((h (orgtrello-api--get-board :id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/boards/:id"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-cards ()
  (let ((h (orgtrello-api--get-cards :board-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/boards/:board-id/cards"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-card ()
  (let ((h (orgtrello-api--get-card :card-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/cards/:card-id"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-lists ()
  (let ((h (orgtrello-api--get-lists :board-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/boards/:board-id/lists"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-list ()
  (let ((h (orgtrello-api--get-list :list-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/lists/:list-id"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--add-list ()
  (let ((h (orgtrello-api--add-list "list-name" "board-id")))
    (should (equal (gethash :method h) :post))
    (should (equal (gethash :uri    h) "/lists/"))
    (should (equal (gethash :params h) '(("name" . "list-name")
                                         ("idBoard" . "board-id"))))))

(ert-deftest testing-orgtrello-api--add-card ()
  (let ((h (orgtrello-api--add-card "card-name" "list-id")))
    (should (equal (gethash :method h) :post))
    (should (equal (gethash :uri    h) "/cards/"))
    (should (equal (gethash :params h) '(("name" . "card-name") ("idList" . "list-id"))))))

(ert-deftest testing-orgtrello-api--get-cards ()
  (let ((h (orgtrello-api--get-cards :list-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/lists/:list-id/cards"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--move-card ()
  (let ((h (orgtrello-api--move-card :id-card :id-list "name-card")))
    (should (equal (gethash :method h) :put))
    (should (equal (gethash :uri    h) "/cards/:id-card"))
    (should (equal (gethash :params h) '(("name"   . "name-card")
                                         ("idList" . :id-list))))))

(ert-deftest testing-orgtrello-api--move-card-without-name ()
  (let ((h (orgtrello-api--move-card :id-card :id-list)))
    (should (equal (gethash :method h) :put))
    (should (equal (gethash :uri    h) "/cards/:id-card"))
    (should (equal (gethash :params h) '(("idList" . :id-list))))))

(ert-deftest testing-orgtrello-api--add-checklist ()
  (let ((h (orgtrello-api--add-checklist "id-card" "name-checklist")))
    (should (equal (gethash :method h) :post))
    (should (equal (gethash :uri    h) "/cards/id-card/checklists"))
    (should (equal (gethash :params h) '(("name" . "name-checklist"))))))

(ert-deftest testing-orgtrello-api--update-checklist ()
  (let ((h (orgtrello-api--update-checklist :id-checklist "name-checklist")))
    (should (equal (gethash :method h) :put))
    (should (equal (gethash :uri    h) "/checklists/:id-checklist"))
    (should (equal (gethash :params h) '(("name" . "name-checklist"))))))

(ert-deftest testing-orgtrello-api--get-checklists ()
  (let ((h (orgtrello-api--get-checklists :card-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/cards/:card-id/checklists"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--get-checklist ()
  (let ((h (orgtrello-api--get-checklist :checklist-id)))
    (should (equal (gethash :method h) :get))
    (should (equal (gethash :uri    h) "/checklists/:checklist-id"))
    (should (equal (gethash :params h) nil))))

(ert-deftest testing-orgtrello-api--add-tasks ()
  (let ((h (orgtrello-api--add-tasks :checklist-id "task-name" t)))
    (should (equal (gethash :method h) :post))
    (should (equal (gethash :uri    h) "/checklists/:checklist-id/checkItems"))
    (should (equal (gethash :params h) '(("name"  . "task-name")
                                         ("checked" . t))))))

(ert-deftest testing-orgtrello-api--update-task ()
  (let ((h (orgtrello-api--update-task :card-id :checklist-id :task-id :task-name "incomplete")))
    (should (equal (gethash :method h) :put))
    (should (equal (gethash :uri    h) "/cards/:card-id/checklist/:checklist-id/checkItem/:task-id"))
    (should (equal (gethash :params h) '(("name"  . :task-name)
                                         ("state" ."incomplete"))))))

(provide 'orgtrello-api-tests)

;;; orgtrello-api-tests.el end here
