<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>${username}</h5>
    ${message?ifExists}
    <form method="post">
        <div class="form-group col-md-4">
            <label for="exampleInputPassword1">Password:</label>
            <input type="password" class="form-control" name="password" placeholder="input password"/>
        </div>
        <div class="form-group col-md-4">
            <label for="exampleInputPassword1">Email:</label>
            <input type="email" class="form-control" name="email" placeholder="input email" value="${email!''}"/>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">
           Save
        </button>
    </form>
</@c.page>