<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script
  src="https://code.jquery.com/jquery-2.2.4.min.js"
  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
  crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $('[name="answer"]').on("change", function(){
                $('#form').trigger("submit");
            })
        })
    </script>
</head>
<body>
    <form id="form" action="index2.php" method="POST">
        <input type="hidden" name="gender" value="<?php echo $_GET['gender']; ?>" />
        <div class="row">
            <div class="col-sm-offset-4 col-sm-4">
                <div class="thumbnail">
                    <img src="http://i.epochtimes.com/assets/uploads/2016/07/05c1348a7d53f02a1cc861f01d21878e-600x400.jpg">
                    <div class="caption text-center">
                        <h3>Name</h3>
                        <h4>20</h4>
                        <p>Description</p>
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-default">
                                <input type="radio" name="answer" value="like" autocomplete="off">喜歡
                            </label>
                            <label class="btn btn-default">
                                <input type="radio" name="answer" value="unlike" autocomplete="off">不喜歡
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>