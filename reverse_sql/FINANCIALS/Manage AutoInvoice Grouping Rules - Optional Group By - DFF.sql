/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Grouping%20Rules%20-%20Optional%20Group%20By%20-%20DFF.sql $:
 * $Id: Manage AutoInvoice Grouping Rules - Optional Group By - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_GROUP_BYS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select RaGroupingRules.NAME                                 RES_NAME
        , ( select  meaning  FROM AR_LOOKUPS ArLookupEO 
		      WHERE ArLookupEO.LOOKUP_TYPE = 'GROUPING_TRX_TYPE' 
				and ArLookupEO.LOOKUP_CODE = detail.class)			RES_TRANSACTION_CLASS
		  ,(select replace(RaGroupByColumns.FROM_COLUMN_NAME,'L.','')
		    FROM RA_GROUP_BY_COLUMNS RaGroupByColumns
			 where RaGroupByColumns.COLUMN_TYPE!='M' 
			 and RaGroupByColumns.column_id = RaGroupBys.column_id)				RES_OPTIONAL_GROUPING_CHARACTE
,RaGroupBys.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RaGroupBys.ATTRIBUTE1
,RaGroupBys.ATTRIBUTE2
,RaGroupBys.ATTRIBUTE3
,RaGroupBys.ATTRIBUTE4
,RaGroupBys.ATTRIBUTE5
,RaGroupBys.ATTRIBUTE6
,RaGroupBys.ATTRIBUTE7
,RaGroupBys.ATTRIBUTE8
,RaGroupBys.ATTRIBUTE9
,RaGroupBys.ATTRIBUTE10
,RaGroupBys.ATTRIBUTE11
,RaGroupBys.ATTRIBUTE12
,RaGroupBys.ATTRIBUTE13
,RaGroupBys.ATTRIBUTE14
,RaGroupBys.ATTRIBUTE15
,RaGroupBys.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,RaGroupBys.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,RaGroupBys.CREATED_BY  RSC_CREATED_BY
,RaGroupBys.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM     RA_GROUPING_RULES RaGroupingRules 
, RA_GROUPING_TRX_TYPES Detail
,RA_GROUP_BYS  RaGroupBys
where (RaGroupBys.ATTRIBUTE_CATEGORY IS NOT NULL OR
RaGroupBys.ATTRIBUTE1 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE2 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE3 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE4 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE5 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE6 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE7 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE8 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE9 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE10 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE11 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE12 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE13 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE14 IS NOT NULL OR 
RaGroupBys.ATTRIBUTE15 IS NOT NULL
)and   RaGroupingRules.grouping_rule_id = detail.grouping_rule_id
AND      Detail.GROUPING_TRX_TYPE_ID      =  RaGroupBys.GROUPING_TRX_TYPE_ID
ORDER BY RES_NAME,RES_TRANSACTION_CLASS,RES_OPTIONAL_GROUPING_CHARACTE
