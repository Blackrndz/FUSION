/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description: TEST JENKIN ERROR
 * ************************************************************************** */
 

SELECT MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME RES_TRANSACTION_SOURCE_NAME
,MtlTxnTypes.TRANSACTION_TYPE_NAME RES_TRANSACTION_TYPE_NAME
,MtlTxnTypes.DESCRIPTION RES_DESCRIPTION
,(CASE
	WHEN MtlTxnTypes.USER_DEFINED_FLAG = 'Y' THEN
		(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'INV_TRANSACTION_ACTION'
		AND LOOKUP_CODE = MtlTxnTypes.TRANSACTION_ACTION_ID)
	ELSE
		NULL
	END) RES_ACTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_USER_DEFINED'
	AND LOOKUP_CODE = MtlTxnTypes.USER_DEFINED_FLAG
	) RES_DEFINED_BY
,DECODE(MtlTxnTypes.STATUS_CONTROL_FLAG,1,'Yes','No') RES_ENABLE_STATUS_CONTROL
,DECODE(MtlTxnTypes.TYPE_CLASS,1,'Yes',2,'No') RES_ALLOW_PROJECT_TRANSACTIONS
,DECODE(MtlTxnTypes.LOCATION_REQUIRED_FLAG,'Y','Yes','No') RES_LOCATION_REQUIRED
,TO_CHAR(MtlTxnTypes.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(MtlTxnTypes.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,MtlTxnTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlTxnTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlTxnTypes.CREATED_BY RSC_CREATED_BY
,MtlTxnTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_TXN_SOURCE_TYPES_VL MtlTxnSourceTypes
,INV_TRANSACTION_TYPES_VL  MtlTxnTypes
WHERE ((MtlTxnSourceTypes.transaction_source_type_id NOT IN(8,18)
	AND(FUSION.inv_logistics_release_level.get_logistics_release_level < 10))
	OR(FUSION.inv_logistics_release_level.get_logistics_release_level >= 10)
	)
AND MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_ID = MtlTxnTypes.TRANSACTION_SOURCE_TYPE_ID
ORDER BY MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME
,MtlTxnTypes.TRANSACTION_TYPE_NAME