<?php
require_once(__DIR__.'/admin.php');

/* ------------------- Preparing data for template ------------------------------------- */
# Getting users one by one is quite ineffective, so building query to do this
$db = UserConfig::getDB();

if (!($stmt = $db->prepare('SELECT a.id, a.name, a.plan_slug, a.schedule_slug, SUM(c.amount) AS debt FROM u_accounts AS a JOIN u_account_charge AS c ON a.id = c.account_id GROUP BY c.account_id HAVING debt < 0'))) {
	throw new DBPrepareStmtException($db);
}

if (!$stmt->execute()) {
	throw new DBExecuteStmtException($db, $stmt);
}

if (!$stmt->bind_result($id, $name, $plan, $schedule, $debt)) {
	throw new DBBindResultException($db, $stmt);
}

$debtors = array();
while ($stmt->fetch() === TRUE) {
	$debtors[] = array('id' => $id, 'name' => $name, 'plan' => $plan, 'schedule' => $schedule, 'debt' => sprintf("%.2f", abs($debt)));
}

$stmt->close();

$template_data['debtors'] = $debtors;
$template_data['USERSROOTURL'] = UserConfig::$USERSROOTURL;
/* ------------------- / Preparing data for template -------------------------------------- */

$ADMIN_SECTION = 'outstanding';

require_once(__DIR__.'/header.php');

StartupAPI::$template->display('@startupapi-admin/outstanding.html.twig', $template_data);

require_once(__DIR__.'/footer.php');
