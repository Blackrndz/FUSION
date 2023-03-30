/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Invoice%20Formats%20-%20Invoice%20Format%20Details.sql $:
 * $Id: Manage Invoice Formats - Invoice Format Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT pjbINVOICEformatEO.NAME	RES_NAME
,pjbINVformatDeEO.START_POSITION RES_START_POSITION
,pjbINVformatDeEO.END_POSITION RES_END_POSITION
,(SELECT NAME FROM PJB_INV_GROUP_COLUMN
	WHERE INVOICE_GROUP_COLUMN_ID = pjbINVformatDeEO.INVOICE_GROUP_COLUMN_ID) RES_FIELD_NAME
,pjbINVformatDeEO.TEXT RES_TEXT
,DECODE(pjbINVformatDeEO.RIGHT_JUSTIFY_FLAG,'Y','Yes','No')	RES_RIGHT_JUSTIFY
,pjbINVformatDeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjbINVformatDeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjbINVformatDeEO.CREATED_BY RSC_CREATED_BY
,pjbINVformatDeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJB_INVOICE_FORMATS pjbINVOICEformatEO
,PJB_INV_FORMAT_DETAILS pjbINVformatDeEO
WHERE pjbINVOICEformatEO.INVOICE_FORMAT_ID = pjbINVformatDeEO.INVOICE_FORMAT_ID
ORDER BY pjbINVOICEformatEO.NAME


