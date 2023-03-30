/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT IbyFormatsVl.FORMAT_NAME RES_NAME
,IbyFormatsVl.FORMAT_CODE RES_CODE
,FormatTypeEO.FORMAT_TYPE_NAME RES_TYPE
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_MESSAGE_DIRECTION'
	AND LookupPEO.LOOKUP_CODE   = FormatTypeEO.MESSAGE_DIRECTION
	) RES_MESSAGE_DIRECTION
,DECODE(IbyFormatsVl.TRANSFORM_PROGRAM_TYPE,'WEB_SERVICE','Web service','ADFBC',
	'Application development framework business component','XDO','BI Publisher') RES_TRANSFORMATION_PROGRAM_TYP
,IbyFormatsVl.FORMAT_TEMPLATE_CODE RES_BI_PUBLISHER_TEMPLATE
,IbyFormatsVl.TRANSFORM_SRVC_INTERFACE_CLASS RES_CLASS_NAME
,DECODE(IbyFormatsVl.TRANSFORM_PROGRAM_TYPE, 'XDO', NULL, DECODE(IbyFormatsVl.SHREDDING_HANDLED_BY_PARSER,'Y','Parser','N','Framework')) RES_SHREDDING
,IbyFormatsVl.TRANSFORM_METHOD RES_METHOD
,(SELECT CodeMapGroupEO.CODE_MAP_GROUP_NAME
	FROM IBY_CODE_MAP_GROUPS_VL CodeMapGroupEO
	WHERE CodeMapGroupEO.CODE_MAP_GROUP_CODE = IbyFormatsVl.CODE_MAP_GROUP_CODE
	) RES_CODE_MAP_GROUP
,TO_CHAR(IbyFormatsVl.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(Extract(Year From IbyFormatsVl.End_Date),'4712',NULL,To_Char(IbyFormatsVl.End_Date,'DD-Mon-YYYY')) AS RES_TO_DATE
,IbyFormatsVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbyFormatsVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbyFormatsVl.CREATED_BY RSC_CREATED_BY
,IbyFormatsVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_FORMATS_VL IbyFormatsVl
,IBY_FORMAT_TYPES_VL FormatTypeEO
WHERE IbyFormatsVl.FORMAT_TYPE_CODE = FormatTypeEO.FORMAT_TYPE_CODE
ORDER BY IbyFormatsVl.FORMAT_NAME