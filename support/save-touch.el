(require 'deferred)

(defun ssh-touch-action ()
  (when (equal (cl-subseq (f-split (f-dirname (buffer-file-name))) 0 7)
               '("/" "Users" "michael" "repos" "NCCTS" "nccts.org" "site"))
    (progn
      (message (concat "ssh-touch-action: "
                       (f-relative (buffer-file-name)
                                   "/Users/michael/repos/NCCTS/nccts.org/site/")))
      (deferred:$
        (deferred:process "ssh"
          "-i"
          "/Users/michael/.vagrant.d/insecure_private_key"
          "core@172.16.253.184"
          (concat "touch /home/core/vagrant/site/"
                  (f-relative (buffer-file-name)
                              "/Users/michael/repos/NCCTS/nccts.org/site/")))))))

(add-hook 'after-save-hook #'ssh-touch-action)
