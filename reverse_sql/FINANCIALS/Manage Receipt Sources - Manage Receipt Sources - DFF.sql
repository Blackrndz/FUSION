/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Sources%20-%20Manage%20Receipt%20Sources%20-%20DFF.sql $:
 * $Id: Manage Receipt Sources - Manage Receipt Sources - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_BATCH_SOURCES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select BusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,ArBatchSourcesAll.NAME RES_NAME
,ArBatchSourcesAll.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ArBatchSourcesAll.ATTRIBUTE1
,ArBatchSourcesAll.ATTRIBUTE2
,ArBatchSourcesAll.ATTRIBUTE3
,ArBatchSourcesAll.ATTRIBUTE4
,ArBatchSourcesAll.ATTRIBUTE5
,ArBatchSourcesAll.ATTRIBUTE6
,ArBatchSourcesAll.ATTRIBUTE7
,ArBatchSourcesAll.ATTRIBUTE8
,ArBatchSourcesAll.ATTRIBUTE9
,ArBatchSourcesAll.ATTRIBUTE10
,ArBatchSourcesAll.ATTRIBUTE11
,ArBatchSourcesAll.ATTRIBUTE12
,ArBatchSourcesAll.ATTRIBUTE13
,ArBatchSourcesAll.ATTRIBUTE14
,ArBatchSourcesAll.ATTRIBUTE15
,ArBatchSourcesAll.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,ArBatchSourcesAll.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,ArBatchSourcesAll.CREATED_BY  RSC_CREATED_BY
,ArBatchSourcesAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,ArBatchSourcesAll.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
	FROM FUSION.AR_BATCH_SOURCES_ALL ArBatchSourcesAll
	,FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,FUSION.AR_SYSTEM_PARAMETERS_ALL ArSystemParametersAll
where (ArBatchSourcesAll.ATTRIBUTE_CATEGORY IS NOT NULL OR
ArBatchSourcesAll.ATTRIBUTE1 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE2 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE3 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE4 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE5 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE6 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE7 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE8 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE9 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE10 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE11 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE12 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE13 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE14 IS NOT NULL OR 
ArBatchSourcesAll.ATTRIBUTE15 IS NOT NULL 
)
AND BusinessUnitPEO.BU_ID                        = ArBatchSourcesAll.ORG_ID
AND BusinessUnitPEO.BU_ID                        = ArSystemParametersAll.ORG_ID
and ARSYSTEMPARAMETERSALL.SITE_REQUIRED_FLAG    is not null
ORDER BY RES_BUSINESS_UNIT,RES_NAME


/*SELECT QRSLT.BU_NAME RES_BUSINESS_UNIT
,QRSLT.NAME1 RES_NAME
, DFF.FIELD_NAME RES_FIELD_NAME
, DFF.field_value RES_FIELD_VALUE
,NULL mapper
,QRSLT.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,QRSLT.last_update_date AS RSC_LAST_UPDATE_DATE
FROM
	(SELECT BusinessUnitPEO.BU_NAME
	,ArBatchSourcesAll.BATCH_SOURCE_ID
	,ArBatchSourcesAll.OBJECT_VERSION_NUMBER
	,ArBatchSourcesAll.BATCH_SOURCE_SEQ_ID
	,ArBatchSourcesAll.NAME AS NAME1
	,ARBATCHSOURCESALL.DESCRIPTION
	,DECODE(ArBatchSourcesAll.TYPE,'AUTOMATIC','Automatic','Manual') TYPE
	,ArBatchSourcesAll.DEFAULT_RECEIPT_CLASS_ID
	,ArBatchSourcesAll.ORG_ID
	,ArBatchSourcesAll.DEFAULT_RECEIPT_METHOD_ID
	,ARBATCHSOURCESALL.REMIT_BANK_ACCT_USE_ID	
	,ArBatchSourcesAll.LAST_BATCH_NUM
	,ArBatchSourcesAll.START_DATE_ACTIVE
	,ArBatchSourcesAll.END_DATE_ACTIVE
	,ArBatchSourcesAll.DEFAULT_REMIT_BANK_ACCOUNT_ID
	,BusinessUnitPEO.BU_ID
	,ARBATCHSOURCESALL.LAST_UPDATED_BY
	,ArBatchSourcesAll.last_update_date
	FROM FUSION.AR_BATCH_SOURCES_ALL ArBatchSourcesAll
	,FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,FUSION.AR_SYSTEM_PARAMETERS_ALL ArSystemParametersAll
	WHERE 
	WHERE BusinessUnitPEO.BU_ID                        = ArBatchSourcesAll.ORG_ID
	AND BusinessUnitPEO.BU_ID                        = ArSystemParametersAll.ORG_ID
	and ARSYSTEMPARAMETERSALL.SITE_REQUIRED_FLAG    is not null
	) QRSLT 
	, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
																			  ,P_DFF_CODE => 'AR_BATCH_SOURCES'
																			  ,P_BASE_TABLE => 'AR_BATCH_SOURCES_ALL'
																			  ,P_PK_COLUMN_1 => 'BATCH_SOURCE_ID'																  
	)) DFF
where DFF.FIELD_VALUE                     IS NOT NULL
and QRSLT.BATCH_SOURCE_ID = TO_NUMBER(DFF.COL_1)
and QRSLT.ORG_ID = ##BUSINESS_UNIT_ID##
AND(QRSLT.LAST_UPDATED_BY ##LAST_UPDATED_BY_OPERATOR##(##USER_NAME_LIST##)
AND QRSLT.LAST_UPDATE_DATE ##LAST_UPDATE_DATE_OPERATOR## TO_DATE('##SEEDED_DATE##'))
ORDER BY RES_BUSINESS_UNIT,RES_NAME*/