/* ****************************************************************************
 * $Revision: 56651 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-12 11:49:53 +0700 (Tue, 12 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Terms%20-%20Installments.sql $:
 * $Id: Manage Payment Terms - Installments.sql 56651 2016-07-12 04:49:53Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT QRSLT.RULE_NAME RES_NAME
,QRSLT.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_USER_DEFINED'
	AND LOOKUP_CODE = QRSLT.USER_DEFINED_FLAG
	) RES_DEFINED_BY
,DECODE(QRSLT.ENABLED_FLAG,'Y','Yes','No') RES_ACTIVE
,DECODE(QRSLT.PARTIAL_ALLOWED_FLAG,'Y','Yes','No') RES_ALLOW_PARTIAL_PICKING
,QRSLT.SHELF_DAYS RES_SHELF_LIFE_DAYS
,DECODE(QRSLT.SINGLE_LOT,'Y','Yes','No') RES_ENFORCE_SINGLE_LOT
,(CASE
	WHEN QRSLT.LOCATOR_SORT_RANK = 1 THEN
		DECODE(QRSLT.LOCATOR_SORT,1,'Locator ascending',2,'Locator descending',3,'Locator receipt date ascending',4,'Locator receipt date descending')
	WHEN QRSLT.LOT_SORT_RANK = 1 THEN
		DECODE(QRSLT.LOT_SORT,1,'Lot ascending',2,'Lot descending',3,'Lot FIFO',4,'Lot FEFO')
	WHEN QRSLT.REVISION_SORT_RANK = 1 THEN
		DECODE(QRSLT.REVISION_SORT,1,'Revision ascending',2,'Revision descending',3,'Revision effective date ascending',4,'Revision effective date descending')
	WHEN QRSLT.SUBINVENTORY_SORT_RANK = 1 THEN
		DECODE(QRSLT.SUBINVENTORY_SORT,1,'Subinventory ascending',2,'Subinventory descending',3,'Subinventory receipt date ascending',4,'Subinventory receipt date descending')
	END) RES_PRIORITY_1
,(CASE
	WHEN QRSLT.LOCATOR_SORT_RANK = 2 THEN
		DECODE(QRSLT.LOCATOR_SORT,1,'Locator ascending',2,'Locator descending',3,'Locator receipt date ascending',4,'Locator receipt date descending')
	WHEN QRSLT.LOT_SORT_RANK = 2 THEN
		DECODE(QRSLT.LOT_SORT,1,'Lot ascending',2,'Lot descending',3,'Lot FIFO',4,'Lot FEFO')
	WHEN QRSLT.REVISION_SORT_RANK = 2 THEN
		DECODE(QRSLT.REVISION_SORT,1,'Revision ascending',2,'Revision descending',3,'Revision effective date ascending',4,'Revision effective date descending')
	WHEN QRSLT.SUBINVENTORY_SORT_RANK = 2 THEN
		DECODE(QRSLT.SUBINVENTORY_SORT,1,'Subinventory ascending',2,'Subinventory descending',3,'Subinventory receipt date ascending',4,'Subinventory receipt date descending')
	END) RES_PRIORITY_2
,(CASE
	WHEN QRSLT.LOCATOR_SORT_RANK = 3 THEN
		DECODE(QRSLT.LOCATOR_SORT,1,'Locator ascending',2,'Locator descending',3,'Locator receipt date ascending',4,'Locator receipt date descending')
	WHEN QRSLT.LOT_SORT_RANK = 3 THEN
		DECODE(QRSLT.LOT_SORT,1,'Lot ascending',2,'Lot descending',3,'Lot FIFO',4,'Lot FEFO')
	WHEN QRSLT.REVISION_SORT_RANK = 3 THEN
		DECODE(QRSLT.REVISION_SORT,1,'Revision ascending',2,'Revision descending',3,'Revision effective date ascending',4,'Revision effective date descending')
	WHEN QRSLT.SUBINVENTORY_SORT_RANK = 3 THEN
		DECODE(QRSLT.SUBINVENTORY_SORT,1,'Subinventory ascending',2,'Subinventory descending',3,'Subinventory receipt date ascending',4,'Subinventory receipt date descending')
	END) RES_PRIORITY_3
,(CASE
	WHEN QRSLT.LOCATOR_SORT_RANK = 4 THEN
		DECODE(QRSLT.LOCATOR_SORT,1,'Locator ascending',2,'Locator descending',3,'Locator receipt date ascending',4,'Locator receipt date descending')
	WHEN QRSLT.LOT_SORT_RANK = 4 THEN
		DECODE(QRSLT.LOT_SORT,1,'Lot ascending',2,'Lot descending',3,'Lot FIFO',4,'Lot FEFO')
	WHEN QRSLT.REVISION_SORT_RANK = 4 THEN
		DECODE(QRSLT.REVISION_SORT,1,'Revision ascending',2,'Revision descending',3,'Revision effective date ascending',4,'Revision effective date descending')
	WHEN QRSLT.SUBINVENTORY_SORT_RANK = 4 THEN
		DECODE(QRSLT.SUBINVENTORY_SORT,1,'Subinventory ascending',2,'Subinventory descending',3,'Subinventory receipt date ascending',4,'Subinventory receipt date descending')
	END) RES_PRIORITY_4
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT InventoryRuleEO.DESCRIPTION
	,InventoryRuleEO.ENABLED_FLAG
	,InventoryRuleEO.USER_DEFINED_FLAG
	,InventoryRuleEO.RULE_NAME
	,PickReleaseRuleEO.SINGLE_LOT
	,PickReleaseRuleEO.PARTIAL_ALLOWED_FLAG
	,PickReleaseRuleEO.LOT_SORT
	,PickReleaseRuleEO.LOT_SORT_RANK
	,PickReleaseRuleEO.REVISION_SORT
	,PickReleaseRuleEO.REVISION_SORT_RANK
	,PickReleaseRuleEO.SUBINVENTORY_SORT
	,PickReleaseRuleEO.SUBINVENTORY_SORT_RANK
	,PickReleaseRuleEO.LOCATOR_SORT
	,PickReleaseRuleEO.LOCATOR_SORT_RANK
	,PickReleaseRuleEO.CREATION_DATE
	,PickReleaseRuleEO.CREATED_BY
	,PickReleaseRuleEO.LAST_UPDATE_DATE
	,PickReleaseRuleEO.LAST_UPDATED_BY
	,PickReleaseRuleEO.SHELF_DAYS
	FROM INV_RULES_VL InventoryRuleEO
	,INV_PICKING_RULES PickReleaseRuleEO
	WHERE InventoryRuleEO.RULE_ID = PickReleaseRuleEO.WMS_RULE_ID
	UNION ALL
	SELECT InventoryRuleEO.DESCRIPTION
	,InventoryRuleEO.ENABLED_FLAG
	,InventoryRuleEO.USER_DEFINED_FLAG
	,InventoryRuleEO.RULE_NAME
	,'N'                                   AS SINGLE_LOT
	,'Y'                                   AS PARTIAL_ALLOWED_FLAG
	,NULL                                  AS LOT_SORT
	,NULL                                  AS LOT_SORT_RANK
	,NULL                                  AS REVISION_SORT
	,NULL                                  AS REVISION_SORT_RANK
	,3                                     AS SUBINVENTORY_SORT
	,1                                     AS SUBINVENTORY_SORT_RANK
	,3                                     AS LOCATOR_SORT
	,2                                     AS LOCATOR_SORT_RANK
	,InventoryRuleEO.CREATION_DATE
	,InventoryRuleEO.CREATED_BY
	,InventoryRuleEO.LAST_UPDATE_DATE
	,InventoryRuleEO.LAST_UPDATED_BY
	,NULL                                  AS SHELF_DAYS
	FROM INV_RULES_VL InventoryRuleEO
	WHERE InventoryRuleEO.RULE_ID = 1
	UNION ALL
	SELECT InventoryRuleEO.DESCRIPTION
	,InventoryRuleEO.ENABLED_FLAG
	,InventoryRuleEO.USER_DEFINED_FLAG
	,InventoryRuleEO.RULE_NAME
	,'N'                                   AS SINGLE_LOT
	,'Y'                                   AS PARTIAL_ALLOWED_FLAG
	,1                                     AS LOT_SORT
	,1                                     AS LOT_SORT_RANK
	,NULL                                  AS REVISION_SORT
	,NULL                                  AS REVISION_SORT_RANK
	,3                                     AS SUBINVENTORY_SORT
	,2                                     AS SUBINVENTORY_SORT_RANK
	,3                                     AS LOCATOR_SORT
	,3                                     AS LOCATOR_SORT_RANK
	,InventoryRuleEO.CREATION_DATE
	,InventoryRuleEO.CREATED_BY
	,InventoryRuleEO.LAST_UPDATE_DATE
	,InventoryRuleEO.LAST_UPDATED_BY
	,NULL                                  AS SHELF_DAYS
	FROM INV_RULES_VL InventoryRuleEO
	WHERE InventoryRuleEO.RULE_ID = 2
	UNION ALL
	SELECT InventoryRuleEO.DESCRIPTION
	,InventoryRuleEO.ENABLED_FLAG
	,InventoryRuleEO.USER_DEFINED_FLAG
	,InventoryRuleEO.RULE_NAME
	,'N'                                   AS SINGLE_LOT
	,'Y'                                   AS PARTIAL_ALLOWED_FLAG
	,NULL                                  AS LOT_SORT
	,NULL                                  AS LOT_SORT_RANK
	,NULL                                  AS REVISION_SORT
	,NULL                                  AS REVISION_SORT_RANK
	,NULL                                  AS SUBINVENTORY_SORT
	,NULL                                  AS SUBINVENTORY_SORT_RANK
	,NULL                                  AS LOCATOR_SORT
	,NULL                                  AS LOCATOR_SORT_RANK
	,InventoryRuleEO.CREATION_DATE
	,InventoryRuleEO.CREATED_BY
	,InventoryRuleEO.LAST_UPDATE_DATE
	,InventoryRuleEO.LAST_UPDATED_BY
	,NULL                                  AS SHELF_DAYS
	FROM INV_RULES_VL InventoryRuleEO
	WHERE InventoryRuleEO.RULE_ID = 14
	) QRSLT
WHERE QRSLT.USER_DEFINED_FLAG = 'Y'
ORDER BY RULE_NAME

/*Add condition QRSLT.USER_DEFINED_FLAG to filter only data that have been created by User.*/